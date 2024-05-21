import requests
import pandas as pd
from sqlalchemy import create_engine
import oracledb
import json
def Salesdata():
    # OpenAPI URL
    url = "http://openapi.seoul.go.kr:8088/4c6a5465426b617238316d48747050/json/tbLnOpendataRtmsV/1/100/2024/%20/%20/%20/%20/%20/%20/%20/%20/%20/아파트"
    # API 요청 및 응답 확인
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        # 데이터프레임으로 변환
        df = pd.DataFrame(data['tbLnOpendataRtmsV']['row'])
        # 모든 데이터를 문자열로 변환
        df = df.astype(str)
        # 데이터프레임을 CSV로 저장 (디버깅용)
        df.to_csv('crawling.csv', index=False, encoding='utf-8-sig')
        # Oracle DB 연결 정보
        path = 'oracle+oracledb://boo:12345@localhost:1521/?service_name=xe'
        engine = create_engine(path)
        # Oracle 클라이언트 초기화 (환경에 따라 필요하지 않을 수 있음)
        oracledb.init_oracle_client()
        # 데이터프레임을 Oracle 데이터베이스에 저장
        df.to_sql(name='sales', con=engine, if_exists='replace', index=None)
    else:
        print(f"Failed to retrieve data: {response.status_code}")