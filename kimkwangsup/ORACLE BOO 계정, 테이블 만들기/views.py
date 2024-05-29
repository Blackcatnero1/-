'''
    이 함수들은 OPENAPI에서 데이터를 크롤링해주는 함수, 스프링에서 응답받아 서브기능의 그래프들을 호출해주는 함수, 
    구를 입력받아서 뷰로 넘겨주는 함수, 구.아파트 를 입력받아서 해당 매물의 상세정보를 챗봇창에 출력해주는 함수입니다.
    @author  김광섭, 전민경
    @since	 2024.05.29
    @version V.1.0
             2024.05.29 - 크롤링, 매물 관련 클래스 제작 [ 담당자 : 김광섭 ] 
             2024.05.29 - 그래프 클래스 제작 [ 담당자 : 전민경 ] 
'''
from django.shortcuts import render
import oracledb
import pandas as pd
from sqlalchemy import create_engine
from django.shortcuts import redirect
import requests
import json
import cx_Oracle
from django.http import HttpResponse
from django.http import JsonResponse,HttpResponseRedirect
from django.views.decorators.csrf import csrf_exempt
from io import BytesIO
import plotly.express as px 
import matplotlib
import matplotlib.pyplot as plt
from . import graph as gp

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
        dsn_tns = cx_Oracle.makedsn('localhost', '1521', service_name='xe')
        engine = create_engine(f'oracle+cx_oracle://boo:12345@{dsn_tns}')
        # 데이터프레임을 Oracle 데이터베이스에 저장
        sql_df = pd.read_sql("SELECT acc_year, sgg_cd, sgg_nm, bjdong_cd, bjdong_nm, land_gbn, land_gbn_nm, "
                             +"LPAD(bonbeon, 4, '0') AS bonbeon, LPAD(bubeon, 4, '0') AS bubeon, bldg_nm, obj_amt, "
                             +"bldg_area, tot_area, floor, right_gbn, cntl_ymd, build_year, house_type, req_gbn, rdealer_lawdnm "
                             +"FROM sales order by deal_ymd desc", engine).head(150)
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
    


#구별 연평균 증가율

def getNums(req):
    j1 = gp.getNums()
    return JsonResponse({'data': j1})

#구별 평당 매매가

def getPrice(req):
    tag_data = gp.getPrice()
    return render(req, 'boogi/lmn.html', {'tag_data': tag_data})


def send_data_to_controller(jibeon_value):
    url = "http://58.72.151.124:6001/boo/map/map.boo?juso=" + jibeon_value
    payload = {
        "jibeon": jibeon_value
    }

    try:
        response = requests.post(url, data=payload)
        return response.status_code
    except Exception as e:
        return None        
        
@csrf_exempt
def callback(request):
    if request.method == 'POST':
        try:
            payload = json.loads(request.body.decode('utf-8'))
            contexts = payload.get('contexts', [])
            if contexts:
                select_gu = contexts[0].get('params', {}).get('구이름', {}).get('resolvedValue', '')
            else:
                select_gu = ''
            user_message = payload.get('userRequest', {}).get('utterance', '')
            if not select_gu:
                title = '말씀하신 내용을 이해할 수가 없어요'
                description = '해당 매물이 없습니다.'
                template = {
                    "outputs": [
                        {
                            "simpleText": {
                                "text": "말씀하신 내용을 이해할 수가 없어요.\n\n다시 입력해 주세요."
                            }
                        }
                    ]
                }
                response = {
                    "version": "2.0",
                    "template": template
                }
                return JsonResponse(response)
            
            dsn_tns = cx_Oracle.makedsn('localhost', '1521', service_name='xe')
            engine = create_engine(f'oracle+cx_oracle://boo:12345@{dsn_tns}')
            areagrade = ['소형', '중형', '대형']
            df_total = pd.DataFrame()
            for i in range(len(areagrade)):
                query = f"""
                        SELECT 
                            areagrade, nns.deal_ymd, nns.obj_amt, nns.bldg_area, nns.floor, nns.build_year, nns.bjdong_nm, 
                            nns.sgg_nm, DECODE(nns.bonbeon,'0',null, nns.bonbeon)||DECODE(nns.bubeon, '0', null, '-'||nns.bubeon) AS 지번
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
                        WHERE 
                            bldg_area BETWEEN low_area and high_area 
                            AND AREAGRADE = '{areagrade[i]}'
                            AND rownum = 1 
                            ORDER BY acc_year, areagrade desc
                    """
                df = pd.read_sql(query, engine)
                df_total = pd.concat([df_total, df], ignore_index=True)
            
            items = []
            
            
            
            if df_total.empty:
                title = f"{select_gu} {user_message}"
                description = '😢 해당 매물이 없습니다. 😢'
                items.append(
                    {
                        "title": title,
                        "description": description,
                        "buttons": [
                            {
                                "label": "아파트 명 알고 싶어요.",
                                "action": "webLink",
                                "webLinkUrl": "http://58.72.151.124:6001/boo/list/list.boo?sgg_nm="+select_gu
                            }
                        ]
                    }
                )
            else:
                df_json = df_total.to_json(orient='records')
                json_data = json.loads(df_json)
                result = []
                for pData in json_data:
                    sgg_nm = pData["sgg_nm"]
                    bjdong_nm = pData["bjdong_nm"]
                    jibeon = pData["지번"]
                    areagrade = pData["areagrade"]
                    deal_ymd = str(pData["deal_ymd"])
                    if pData['obj_amt'] // 10000 != 0 and pData['obj_amt'] % 10000 != 0:
                        obj_amt = f"{pData['obj_amt'] // 10000}억 {pData['obj_amt'] % 10000}만원"
                    elif pData['obj_amt'] // 10000 == 0 and pData['obj_amt'] % 10000 != 0:
                        obj_amt = f"{pData['obj_amt'] % 10000}만원"
                    elif pData['obj_amt'] // 10000 != 0 and pData['obj_amt'] % 10000 == 0:
                        obj_amt = f"{pData['obj_amt'] // 10000}억원"
                    bldg_area = pData["bldg_area"]
                    floor = pData["floor"]
                    build_year = pData["build_year"]
                    pyeong = bldg_area / 3.3
                    bldg_area_str = f"{bldg_area:.3f}m²({int(pyeong)}평)"
                    result.append("법정구명 : {}\n"
                                  "상세주소 : {}\n"
                                  "건물면적 : {}\n"
                                  "실계약일 : {}\n"
                                  "실매매가 : {}\n"
                                  "전용면적 : {}\n"
                                  "건물층수 : {}층\n"
                                  "건축년도 : {}년".format(sgg_nm, bjdong_nm + ' ' + jibeon, areagrade, deal_ymd, obj_amt, bldg_area_str, floor, build_year))
                realjibeon = (bjdong_nm + ' ' + jibeon)
                real_bldg = user_message
                url = "http://58.72.151.124:6001/boo/map/map.boo?juso=" + realjibeon
                items.append(
                    {
                        "title": f"{select_gu} {user_message}",
                        "description": "매물 정보입니다.",
                        "buttons": [
                            {
                                "label": "해당 아파트 지도 볼래요.",
                                "action": "webLink",
                                "webLinkUrl": url,
                            },
                            {
                                "label": "다른 아파트도 알고 싶어요.",
                                "action": "block",
                                "blockId": "664712f1f2800447c6289f79"
                            },
                            {
                                "label": "지역 정보를 보고 싶어요.",
                                "action": "block",
                                "blockId": "6646fb1ca6187865af6b0bce"
                            }
                        ]
                    }
                )
                result_items = []
                for result_item in result:
                    result_items.append({
                        "title": '아파트명 : ' + user_message + '\n―――――――――――――――',
                        "description": result_item,
                    })
                items += result_items
            if not df_total.empty:
                template = {
                    "outputs": [
                        {
                            "basicCard": {
                                "title": "⚠️유의사항",
                                "description": "매매 정보란에서 보신 평균 매매가는 2017년~2024년 데이터 평균이므로 \n실거래가와는 차이가 있을수 있습니다."
                            }
                        },
                        {
                            "carousel": {
                                "type": "basicCard",
                                "items": items
                            }
                        }
                    ],
                    "quickReplies": [
                        {
                            "action": "block",
                            "label": "처음으로",
                            "blockId": "6646fb032260b1573785cef4",
                        },
                        {
                            "action": "block",
                            "label": "매매시 주의사항",
                            "blockId": "665538210ed18d50aeb8a8e8",
                        },
                        {
                            "action": "block",
                            "label": "챗봇 도움말",
                            "blockId": "66541a080ed18d50aeb86b37",
                        },
                        {
                            "action": "block",
                            "label": "챗봇 목적",
                            "blockId": "665417a7c4974b2b518fc929",
                        }
                    ]
                }
            response = {
                "version": "2.0",
                "template": template
            }
            return JsonResponse(response)
        except json.JSONDecodeError as e:
            return HttpResponse(status=400)
        except Exception as e:
            return HttpResponse(status=500)
    return HttpResponse(status=405)


    
@csrf_exempt
def guList(request):
    if request.method == 'POST':
        payload = json.loads(request.body.decode('utf-8'))
        select_gu = payload.get('contexts', [{}])[0].get('params', {}).get('구이름', {}).get('resolvedValue', '')
        if select_gu:
            url = f"http://58.72.151.124:6001/boo/list/list.boo?sgg_nm={select_gu}"
            template = {
                "outputs": [
                    {
                        "basicCard": {
                            "title": "구 이름으로 조회한 아파트입니다.",
                            "description": f"아래 버튼을 눌러 {select_gu}에 대한\n아파트 이름을 확인하세요.",
                            "buttons": [
                                {
                                    "action": "webLink",
                                    "label": "아파트명 보러가기",
                                    "webLinkUrl": url
                                }
                            ]
                        }
                    },
                    
                    {
                        "basicCard": {
                            "title": "검색하신 아파트 이름을 입력해주세요.",
                            "description" : "예) 은마, 포레스트힐시티...",
                            "thumbnail": {
                                "imageUrl": "http://58.72.151.124:6012/static/%EC%82%AC%EC%A7%84.png"
                            }
                        }
                    }
                    
                ],
                "quickReplies": [
                    {
                        "action": "block",
                        "label": "처음으로",
                        "blockId": "6646fb032260b1573785cef4",
                    },
                    {
                        "action": "block",
                        "label": "매매시 주의사항",
                        "blockId": "665538210ed18d50aeb8a8e8",
                    },
                    {
                        "action": "block",
                        "label": "챗봇 도움말",
                        "blockId": "66541a080ed18d50aeb86b37",
                    },
                    {
                        "action": "block",
                        "label": "챗봇 목적",
                        "blockId": "665417a7c4974b2b518fc929",
                    }
                ]
            }
        else:
            template = {
                "outputs": [
                    {
                        "simpleText": {
                            "text": "구이름을 찾을 수 없습니다."
                        }
                    }
                ]
            }
        response = {
            "version": "2.0",
            "template": template
        }
        return JsonResponse(response)
