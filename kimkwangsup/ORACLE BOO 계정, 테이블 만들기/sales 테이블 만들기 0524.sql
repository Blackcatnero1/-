CREATE TABLE sales(
    ACC_YEAR NUMBER(4),
    SGG_CD NUMBER(5),
    SGG_NM VARCHAR2(30 CHAR),
    BJDONG_CD NUMBER(5),
    BJDONG_NM VARCHAR2(30 CHAR),
    LAND_GBN VARCHAR2(30 CHAR),
    LAND_GBN_NM VARCHAR2(30 CHAR),
    BONBEON VARCHAR2(10 CHAR),
    BUBEON VARCHAR2(10 CHAR),
    BLDG_NM VARCHAR2(30 CHAR),
    DEAL_YMD NUMBER(8),
    OBJ_AMT NUMBER(10),
    BLDG_AREA NUMBER(10,3),
    TOT_AREA NUMBER(10,3),
    FLOOR NUMBER(3),
    RIGHT_GBN VARCHAR2(30 CHAR),
    CNTL_YMD NUMBER(8),
    BUILD_YEAR NUMBER(4),
    HOUSE_TYPE VARCHAR2(30 CHAR),
    REQ_GBN VARCHAR2(30 CHAR),
    RDEALER_LAWDNM VARCHAR2(30 CHAR)
);

select 
    bjdong_nm ||' '||bonbeon||DECODE(bubeon, '0', null, '-'||bubeon) jibeon, round(avg(area) / 3.3) avg_area,round(avg(obj_amt)) avg, count(*) 
from 
          (
        SELECT
            ACC_YEAR, SGG_CD, SGG_NM, BJDONG_CD, BJDONG_NM, LAND_GBN, LAND_GBN_NM, BONBEON, BUBEON, BLDG_NM, DEAL_YMD, OBJ_AMT, round(BLDG_AREA) area, TOT_AREA, FLOOR, RIGHT_GBN, CNTL_YMD, BUILD_YEAR, HOUSE_TYPE, REQ_GBN, RDEALER_LAWDNM
        FROM
            sales
        WHERE
            obj_amt between 100000 and 999999
            AND bjdong_nm = '가락동'
        )
group by 
    bjdong_nm, bonbeon, bubeon
order by 
    bjdong_nm, bonbeon, bubeon 
;
