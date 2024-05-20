-- system �������� ����
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


-- �Ź� ���̺� ����� (sales)
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

-- �����α� ���̺� �����(population)
CREATE TABLE population (
    gu_code VARCHAR2(10),
    gu_name VARCHAR2(50),
    total NUMBER,
    year NUMBER(4)
);


-- ����������� ���̺� �����
CREATE TABLE areagrade(
    grade VARCHAR2(10 CHAR)
        CONSTRAINT AG_GRADE_NN NOT NULL,
    lowarea NUMBER
        CONSTRAINT AG_LOW_NN NOT NULL,
    higharea NUMBER
        CONSTRAINT AG_HIGH_NN NOT NULL
);
INSERT INTO
    areagrade
VALUES(
    '����', 0, 59.99999999999
);
INSERT INTO
    areagrade
VALUES(
    '����', 60, 84.99999999999
);
INSERT INTO
    areagrade
VALUES(
    '����', 85, 500
);

-- ����, ���̺� ���� �ư� �� ����� ���ӿ��� boo ���� ���� �� �׽�Ʈ