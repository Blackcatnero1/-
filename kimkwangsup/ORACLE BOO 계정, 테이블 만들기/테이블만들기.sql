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
    acc_year VARCHAR2(30 CHAR),
    sgg_cd VARCHAR2(30 CHAR),
    sgg_nm VARCHAR2(30 CHAR),
    bjdong_cd VARCHAR2(30 CHAR),
    bjdong_nm VARCHAR2(30 CHAR),
    land_gbn VARCHAR2(30 CHAR),
    land_gbn_nm VARCHAR2(30 CHAR),
    bonbeon VARCHAR2(30 CHAR),
    bubeon VARCHAR2(30 CHAR),
    bldg_nm VARCHAR2(30 CHAR),
    deal_ymd VARCHAR2(30 CHAR),
    obj_amt VARCHAR2(30 CHAR),
    bldg_area VARCHAR2(30 CHAR),
    tot_area VARCHAR2(30 CHAR),
    floor VARCHAR2(30 CHAR),
    right_gbn VARCHAR2(30 CHAR),
    cntl_ymd VARCHAR2(30 CHAR),
    build_year VARCHAR2(30 CHAR),
    house_type VARCHAR2(30 CHAR),
    req_gbn VARCHAR2(30 CHAR),
    rdealer_lawdnm VARCHAR2(30 CHAR)
);

-- 구별인구 테이블 만들기(population)
CREATE TABLE population (
    gu_code VARCHAR2(10),
    gu_name VARCHAR2(50),
    total NUMBER,
    year NUMBER(4)
);




-- 계정, 테이블 생성 됐고 좌 상단의 접속에서 boo 접속 만든 후 테스트
ALTER TABLE population RENAME COLUMN gu_code TO sgg_cd;
ALTER TABLE population RENAME COLUMN gu_name TO sgg_nm;
ALTER TABLE population RENAME COLUMN total TO p_total;
ALTER TABLE population RENAME COLUMN year TO p_year;
