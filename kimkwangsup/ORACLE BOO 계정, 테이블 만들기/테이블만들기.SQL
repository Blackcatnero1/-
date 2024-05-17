-- system 계정에서 시작
CREATE USER boo IDENTIFIED BY 12345 ACCOUNT UNLOCK;
GRANT UNLIMITED TABLESPACE TO boo;
ALTER USER boo DEFAULT TABLESPACE USERS;
ALTER USER boo TEMPORARY TABLESPACE TEMP;
GRANT CREATE SESSION TO boo;
GRANT CONNECT, RESOURCE TO boo;
GRANT SELECT ANY TABLE TO boo;
GRANT CREATE SYNONYM TO boo;
GRANT CREATE PUBLIC SYNONYM TO boo;
GRANT CREATE VIEW TO boo;
commit;

conn boo/12345;


-- 매물 테이블 만들기 (sales)
CREATE TABLE sales(
    acc_year NUMBER(4),
    sgg_cd NUMBER(5),
    sgg_nm VARCHAR2(10 CHAR),
    bjdong_cd NUMBER(5),
    bjdong_nm VARCHAR2(10 CHAR),
    land_gbn NUMBER(1),
    land_gbn_nm VARCHAR2(10 CHAR),
    bonbeon VARCHAR2(10),
    bubeon NUMBER(4),
    bldg_nm VARCHAR2(30 CHAR),
    deal_ymd NUMBER(10),
    obj_amt NUMBER(10),
    bldg_area NUMBER(8,3),
    tot_area NUMBER(8,3),
    floor NUMBER(3),
    right_gbn VARCHAR2(10 CHAR),
    cntl_ymd NUMBER(8),
    build_year NUMBER(4),
    house_type VARCHAR2(10 CHAR),
    req_gbn VARCHAR2(10 CHAR),
    rdealer_lawdnm VARCHAR2(30 CHAR)
);

-- 구별인구 테이블 만들기(population)
CREATE TABLE population(
    gu_code NUMBER(5)
        CONSTRAINT POP_GC_NN NOT NULL,
    gu_name VARCHAR2(10 CHAR)
        CONSTRAINT POP_GN_NN NOT NULL,
    gu_pop NUMBER
        CONSTRAINT POP_GP_NN NOT NULL
);




