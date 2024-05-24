from django.shortcuts import render
import oracledb
import pandas as pd
from sqlalchemy import create_engine
import requests
import json
import cx_Oracle
from django.http import HttpResponse
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

    
