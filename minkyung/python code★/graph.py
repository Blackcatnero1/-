import os
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import plotly.express as px


#구별 연평균증가율 수치 가져오는 함수
def getNums():
    new = 'd:/study/python'
    os.chdir(new) #데이터 경로 설정
    rd = pd.read_csv('src/rawdata.csv', encoding='cp949')

    #평균매매가 계산
    rd_price_mean = rd.groupby(['자치구명', '접수연도'])['물건금액(만원)'].mean()

    # 자치구별로 연평균 증가율을 저장할 빈 리스트 생성
    cagr_results = []

    # 각 자치구별로 연평균 증가율을 계산
    for gu in rd_price_mean.index.levels[0]:
        gu_data1 = rd_price_mean.loc[gu]  # 특정 자치구의 데이터만 선택
        
        # 연평균 증가율을 계산하기 위해 데이터 정렬
        gu_data1_sorted = gu_data1.sort_index()

        # 연평균 증가율 계산
        start_price = gu_data1_sorted.iloc[0]  # 시작 연도의 매매가
        end_price = gu_data1_sorted.iloc[-1]   # 마지막 연도의 매매가
        periods = len(gu_data1_sorted) - 1     # 총 기간에서 1을 뺀 것이 증가율을 구할 때 사용할 연도 개수

        cagr = ((end_price / start_price) ** (1 / periods)) - 1  # CAGR 공식을 사용하여 연평균 증가율 계산
        cagr_percent = round(cagr * 100, 2)  # 소수점 이하 2자리까지 반올림하고 퍼센트로 변환

        # 결과를 리스트에 추가
        cagr_results.append({'자치구명': gu, 'CAGR': cagr_percent})

    # 결과를 DataFrame으로 변환
    cagr_df = pd.DataFrame(cagr_results)

    #자치구명을 인덱스로 설정
    cagr_df.set_index('자치구명', inplace=True)

    #결과를 json 형식으로 변환하여 반환
    cagr_json_df = cagr_df.to_json(force_ascii=False) 

    # print(cagr_df)
    return cagr_json_df


#구별 면적당 매매가 수치 가져오는 함수
def getPrice():
    # new = 'd:/study/python'
    # os.chdir(new) #데이터 경로 설정
    # rd = pd.read_csv('src/rawdata.csv', encoding='cp949', low_memory=False)
    rd = pd.read_csv('http://localhost:8000/static/rawdata.csv', encoding='cp949', low_memory=False)

    #면적당 매매가 계산
    rd_price = round(rd.groupby(['자치구명'])['물건금액(만원)'].sum() / rd.groupby(['자치구명'])['건물면적(㎡)'].sum(), 2)
    rd_price = rd_price.reset_index()
    rd_price.columns = ['자치구', '면적당 매매가']

    #그래프 생성
    fig = px.bar(rd_price, x='자치구', y='면적당 매매가', color='면적당 매매가', hover_name='자치구')
    fig.update_layout(width=1000, height=700) 

    plot_tag = fig.to_html(full_html=False)
    return plot_tag