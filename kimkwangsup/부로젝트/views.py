from django.shortcuts import render
import oracledb
import pandas as pd
from sqlalchemy import create_engine
import requests
import json
import cx_Oracle
from django.http import HttpResponse
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
# Create your views here.



def index(request):
    return render(request, 'index.html')

def Salesdata(request):
    # OpenAPI URL
    url = "http://openapi.seoul.go.kr:8088/4c6a5465426b617238316d48747050/json/tbLnOpendataRtmsV/1/100/2024/%20/%20/%20/%20/%20/%20/%20/%20/%20/아파트"
    # API 요청 및 응답 확인
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        # 데이터프레임으로 변환
        df = pd.DataFrame(data['tbLnOpendataRtmsV']['row'])
        # 모든 데이터를 문자열로 변환
        # df = df.astype(str)
        # 데이터프레임을 CSV로 저장 (디버깅용)
        # Oracle DB 연결 정보
        dsn_tns = cx_Oracle.makedsn('localhost', '1521', service_name='xe')
        engine = create_engine(f'oracle+cx_oracle://boo:12345@{dsn_tns}')
        # 데이터프레임을 Oracle 데이터베이스에 저장
        sql_df = pd.read_sql("SELECT acc_year, sgg_cd, sgg_nm, bjdong_cd, bjdong_nm, land_gbn, land_gbn_nm, LPAD(bonbeon, 4, '0') AS bonbeon, LPAD(bubeon, 4, '0') AS bubeon, bldg_nm, obj_amt, bldg_area, tot_area, floor, right_gbn, cntl_ymd, build_year, house_type, req_gbn, rdealer_lawdnm FROM sales order by deal_ymd desc", engine).head(150)
        df.columns = df.columns.str.lower()
        columns = [
            "acc_year", "sgg_cd", "sgg_nm", "bjdong_cd", "bjdong_nm", 
            "land_gbn", "land_gbn_nm", "bonbeon", "bubeon", "bldg_nm",
            "obj_amt", "bldg_area", "tot_area", "floor", "right_gbn", 
            "cntl_ymd", "build_year", "house_type", "req_gbn", "rdealer_lawdnm"
        ]
        sql_df_filled = sql_df.fillna("")
        mergedf = pd.concat([df[1:150], sql_df_filled[1:150]],axis=0)
        finaldf = mergedf.drop_duplicates(columns, keep='first')
        realshape =finaldf.shape[0] - sql_df.shape[0]
        read_df = finaldf[:realshape]
        read_df['bonbeon'] = read_df['bonbeon'].astype(int)
        read_df['bubeon'] = read_df['bubeon'].astype(int)
        read_df.to_sql(name='sales', con=engine, if_exists='append', index=None)

        return HttpResponse("Data has been successfully inserted into the database.")
    else:
        return HttpResponse(f"Failed to retrieve data: {response.status_code}")
    


        
        
        
        
@csrf_exempt
def callback(request):
    if request.method == 'POST':
        try:
            payload = json.loads(request.body.decode('utf-8'))
            print(payload)
            contexts = payload.get('contexts', [])
            if contexts:
                select_gu = contexts[0].get('params', {}).get('구이름', {}).get('resolvedValue', '')
            else:
                select_gu = ''  # 기본 값 설정
            user_message = payload.get('userRequest', {}).get('utterance', '')
            
            if not select_gu:  # select_gu가 없는 경우
                title = '말씀하신 내용을 이해할 수가 없어요'  # 또는 '올바른 값을 입력해주세요'
                description = '해당 매물이 없습니다.'
                items = [
                    {
                        "title": title,
                        "description": '다시 입력해주세요',
                        "buttons": [
                            {
                                "label": "처음으로",
                                "action": "block",
                                "blockId": "66470de00466cf5e2cf69b68"
                            }
                        ]
                    }
                ]
                
                template = {
                    "outputs": [
                        {
                            "carousel": {
                                "type": "basicCard",
                                "items": items
                            }
                        }
                    ]
                }

                response = {
                    "version": "2.0",
                    "template": template
                }
                
                return JsonResponse(response)

            # select_gu가 비어있지 않은 경우
            dsn_tns = cx_Oracle.makedsn('localhost', '1521', service_name='xe')
            engine = create_engine(f'oracle+cx_oracle://boo:12345@{dsn_tns}')
            areagrade = ['소형', '중형', '대형']
            df_total = pd.DataFrame()

            for i in range(len(areagrade)):
                query = f"""
                        select areagrade, nns.deal_ymd, nns.obj_amt, nns.bldg_area, nns.floor, nns.build_year, nns.bjdong_nm, nns.sgg_nm
                        FROM areagrade, 
                        (
                            select s.* 
                            from sales s, 
                            (
                                select bjdong_nm, bonbeon, bubeon 
                                from sales 
                                where sgg_nm = '{select_gu}'
                                AND BLDG_NM = '{user_message}'
                                AND ROWNUM = 1
                            ) ns 
                            WHERE s.bjdong_nm = ns.bjdong_nm 
                            AND s.bonbeon = ns.bonbeon 
                            AND s.bubeon = ns.bubeon
                        ) nns 
                        WHERE bldg_area BETWEEN low_area and high_area 
                        AND AREAGRADE = '{areagrade[i]}'
                        AND rownum = 1 
                        ORDER BY acc_year, areagrade desc
                    """
                df = pd.read_sql(query, engine)
                df_total = pd.concat([df_total, df], ignore_index=True)

            if df_total.empty:
                title = f"{select_gu} {user_message}"
                description = '해당 매물이 없습니다.'
                items = [
                    {
                        "title": title,
                        "description": description,
                        "buttons": [
                            {
                                "label": "처음으로",
                                "action": "block",
                                "blockId": "66470de00466cf5e2cf69b68"
                            },
                            {
                                "label": "매물조회",
                                "action": "webLink",
                                "webLinkUrl": "https://example.com"
                            }
                        ]
                    }
                ]
            else:
                df_json = df_total.to_json(orient='records')
                json_data = json.loads(df_json)
                result = []
                for pData in json_data:
                    sgg_nm = pData["sgg_nm"]
                    bjdong_nm = pData["bjdong_nm"]
                    areagrade = pData["areagrade"]
                    deal_ymd = str(pData["deal_ymd"])
                    obj_amt = f"{pData['obj_amt'] // 10000}억 {pData['obj_amt'] % 10000}만원"
                    bldg_area = pData["bldg_area"]
                    floor = pData["floor"]
                    build_year = pData["build_year"]
                    pyeong = bldg_area / 3.3
                    bldg_area_str = f"{bldg_area:.3f}m²({int(pyeong)}평)"

                    result.append("법정구명 : {}\n"
                                "법정동명 : {}\n"
                                "건물면적 : {}\n"
                                "실계약일 : {}\n"
                                "실매매가 : {}\n"
                                "전용면적 : {}\n"
                                "건물층수 : {}층\n"
                                "건축년도 : {}년".format(sgg_nm, bjdong_nm, areagrade, deal_ymd, obj_amt, bldg_area_str, floor, build_year))

                items = [
                    {
                        "title": f"{select_gu} {user_message}",
                        "description": "매물 정보입니다.",
                        "buttons": [
                            {
                                "label": "지도보기",
                                "action": "webLink",
                                "webLinkUrl": "http://"
                            },
                            {
                                "label": "지역정보",
                                "action": "block",
                                "blockId": "664712f1f2800447c6289f79"
                            }
                        ]
                    }
                ]

                result_items = []
                for result_item in result:
                    result_items.append({
                        "description": result_item,
                    })

                items += result_items

            template = {
                "outputs": [
                    {
                        "carousel": {
                            "type": "basicCard",
                            "items": items
                        }
                    }
                ]
            }
            response = {
                "version": "2.0",
                "template": template
            }
            return JsonResponse(response)
        except json.JSONDecodeError as e:
            print(f"JSON decode error: {e}")
            return HttpResponse(status=400)  # 잘못된 요청 응답 반환
        except Exception as e:
            print(f"Unexpected error: {e}")
            return HttpResponse(status=500)  # 내부 서버 오류 응답 반환
    return HttpResponse(status=405)  # 허용되지 않는 메서드 응답 반환