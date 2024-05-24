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


-- 동, 예산등급, rownum 입력할 질의명령
select
    rno, SGG_NM, bjdong_nm, jibeon, bldg_nm, deal_cnt, avg_amt, avg_area 
from
    (
    SELECT 
       rownum rno, SGG_NM, bjdong_nm, jibeon, bldg_nm, deal_cnt, avg_amt, avg_area
    FROM
        (
            SELECT 
                sub.SGG_NM SGG_NM, sub.bjdong_nm BJDONG_NM, sub.jibeon JIBEON, sub.bldg_nm BLDG_NM, deal_cnt DEAL_CNT, avg_amt, avg_area
            FROM 
                (
                SELECT 
                    SGG_NM, bjdong_nm, jibeon, BLDG_NM, ROW_NUMBER() OVER (PARTITION BY 동지번 ORDER BY 아파트이름) AS rn
                FROM 
                    (
                        SELECT
                            bjdong_nm, bonbeon || DECODE(bubeon, '0', null, '-' || bubeon) jibeon, SGG_NM, bldg_nm, bjdong_nm || ' ' || bonbeon || DECODE(bubeon, '0', null, '-' || bubeon) AS 동지번,
                            SGG_NM || ' ' || BLDG_NM AS 아파트이름
                        FROM
                            SALES
                        GROUP BY
                            bjdong_nm, bonbeon, bubeon, SGG_NM, BLDG_NM
                        ORDER BY
                            bjdong_nm, bonbeon, bubeon
                    )
                ) sub,(
                        SELECT 
                            bjdong_nm, bonbeon||DECODE(bubeon, '0', null, '-'||bubeon) jibeon, round(avg(area) / 3.3) avg_area,round(avg(obj_amt)) avg_amt, count(*) deal_cnt 
                        FROM
                                  (
                                SELECT
                                    ACC_YEAR, SGG_CD, SGG_NM, BJDONG_CD, BJDONG_NM, LAND_GBN, LAND_GBN_NM, BONBEON, BUBEON, BLDG_NM, DEAL_YMD, OBJ_AMT, round(BLDG_AREA) area, TOT_AREA, FLOOR, RIGHT_GBN, CNTL_YMD, BUILD_YEAR, HOUSE_TYPE, REQ_GBN, RDEALER_LAWDNM
                                FROM
                                    sales, amtgrade
                                WHERE
                                    grade = '10억 이상 20억 미만'
                                    AND obj_amt between lowamt and highamt
                                    AND bjdong_nm = '가락동'
                                )
                        GROUP BY 
                            bjdong_nm, bonbeon, bubeon
                        ORDER BY 
                            bjdong_nm, bonbeon, bubeon 
                            ) deal
            WHERE 
                rn = 1
                AND sub.bjdong_nm = deal.bjdong_nm
                AND sub.jibeon = deal.jibeon
            order by
                deal_cnt desc
            
        ) li
    )
where 
    rno between 1 and 10
;




-- 동 , 예상등급 입력하면 조회 갯수보여주는 질의명령
select count(*) from
(
SELECT 
       rownum rno, SGG_NM, bjdong_nm, jibeon, bldg_nm, deal_cnt, avg_amt, avg_area
    FROM
        (
            SELECT 
                sub.SGG_NM SGG_NM, sub.bjdong_nm BJDONG_NM, sub.jibeon JIBEON, sub.bldg_nm BLDG_NM, deal_cnt DEAL_CNT, avg_amt, avg_area
            FROM 
                (
                SELECT 
                    SGG_NM, bjdong_nm, jibeon, BLDG_NM, ROW_NUMBER() OVER (PARTITION BY 동지번 ORDER BY 아파트이름) AS rn
                FROM 
                    (
                        SELECT
                            bjdong_nm, bonbeon || DECODE(bubeon, '0', null, '-' || bubeon) jibeon, SGG_NM, bldg_nm, bjdong_nm || ' ' || bonbeon || DECODE(bubeon, '0', null, '-' || bubeon) AS 동지번,
                            SGG_NM || ' ' || BLDG_NM AS 아파트이름
                        FROM
                            SALES
                        GROUP BY
                            bjdong_nm, bonbeon, bubeon, SGG_NM, BLDG_NM
                        ORDER BY
                            bjdong_nm, bonbeon, bubeon
                    )
                ) sub,(
                        SELECT 
                            bjdong_nm, bonbeon||DECODE(bubeon, '0', null, '-'||bubeon) jibeon, round(avg(area) / 3.3) avg_area,round(avg(obj_amt)) avg_amt, count(*) deal_cnt 
                        FROM
                                  (
                                SELECT
                                    ACC_YEAR, SGG_CD, SGG_NM, BJDONG_CD, BJDONG_NM, LAND_GBN, LAND_GBN_NM, BONBEON, BUBEON, BLDG_NM, DEAL_YMD, OBJ_AMT, round(BLDG_AREA) area, TOT_AREA, FLOOR, RIGHT_GBN, CNTL_YMD, BUILD_YEAR, HOUSE_TYPE, REQ_GBN, RDEALER_LAWDNM
                                FROM
                                    sales, amtgrade
                                WHERE
                                    grade = '10억 이상 20억 미만'
                                    AND obj_amt between lowamt and highamt
                                    AND bjdong_nm = '가락동'
                                )
                        GROUP BY 
                            bjdong_nm, bonbeon, bubeon
                        ORDER BY 
                            bjdong_nm, bonbeon, bubeon 
                            ) deal
            WHERE 
                rn = 1
                AND sub.bjdong_nm = deal.bjdong_nm
                AND sub.jibeon = deal.jibeon
            order by
                deal_cnt desc
            
        ) li
)
