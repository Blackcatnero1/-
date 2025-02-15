-- sales 테이블 지우고 다시만들기
CREATE TABLE sales(
    ACC_YEAR VARCHAR2(30 CHAR),
    SGG_CD VARCHAR2(30 CHAR),
    SGG_NM VARCHAR2(30 CHAR),
    BJDONG_CD VARCHAR2(30 CHAR),
    BJDONG_NM VARCHAR2(30 CHAR),
    LAND_GBN VARCHAR2(30 CHAR),
    LAND_GBN_NM VARCHAR2(30 CHAR),
    BONBEON VARCHAR2(30 CHAR),
    BUBEON VARCHAR2(30 CHAR),
    BLDG_NM VARCHAR2(30 CHAR),
    DEAL_YMD VARCHAR2(30 CHAR),
    OBJ_AMT VARCHAR2(30 CHAR),
    BLDG_AREA VARCHAR2(30 CHAR),
    TOT_AREA VARCHAR2(30 CHAR),
    FLOOR VARCHAR2(30 CHAR),
    RIGHT_GBN VARCHAR2(30 CHAR),
    CNTL_YMD VARCHAR2(30 CHAR),
    BUILD_YEAR VARCHAR2(30 CHAR),
    HOUSE_TYPE VARCHAR2(30 CHAR),
    REQ_GBN VARCHAR2(30 CHAR),
    RDEALER_LAWDNM VARCHAR2(30 CHAR)
);


-- 데이터 임포트 한 후 아래 업데이트실행하기

UPDATE sales
SET bonbeon = LPAD(bonbeon, 4, '0'),
    bubeon = LPAD(bubeon, 4, '0')
;

