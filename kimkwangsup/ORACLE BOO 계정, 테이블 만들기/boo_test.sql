
/* 구 + 아파트 로 그룹핑 한 것과 동 + 본번 + 지번 으로 그룹핑 한 것의 개수가 다름
    동 + 본번 + 부번 으로 그룹핑 한 데이터의 갯수가 더 적음으로 분류는 이것을 가지고
    하는것이 맞아 보임
    
    근데 사용자에게 입력을 ??동 ???-?? 이렇게 입력 하라고 할 순 없음.. 
    
    타워 펠리스, 타워 펠리스1, 타워 펠리스 1차 이런식으로 정형화 되지 않고 신고 되어있는 것들이 많아서 생각 좀 해야할듯
    
------------------------------------------------------

지번으로 검색 된 아파트 중 거래량이 가장 많은 데이터의 아파트를
사용자에게 보여줄 아파트로 사용 하되 거래량은 지번으로 검색된 거래량 모두를 보여줘야함

ex)
    가락동 101-3 / 송파구 아키죤아파트 1동/ 2건
    가락동 101-3 / 송파구 아키죤아파트1동(띄어쓰기가 없어서 다른 행..)/ 1건
    
    대표 아파트 이름은 > 송파구 아키죤아파트 1동
    거래수는 > 3건
    
    이렇게 표시 되어야함
    

-------------------------------------------------------


*/


/* 구 + 아파트 로 그룹핑 후 거래량 내림차순*/
SELECT
    SGG_NM||' '||BLDG_NM AS 아파트이름, count(*) as 거래량
FROM
    SALES
GROUP BY
    SGG_NM, BLDG_NM
ORDER BY 
    거래량 DESC
;

/* 구 + 아파트 로 그룹핑한 데이터 개수 9425개*/
SELECT
    COUNT(*)
FROM
    (
    SELECT
        SGG_NM||' '||BLDG_NM AS 아파트이름
    FROM
        SALES
    GROUP BY
        SGG_NM, BLDG_NM
    )
;



/* 동 + 본번 + 부번 으로 그룹핑 후 거래량 내림차순*/
SELECT
    bjdong_nm|| ' ' ||bonbeon||DECODE(bubeon, '0', null, '-'||bubeon) AS 지번,count(*) as 거래량
FROM
    SALES
GROUP BY
    bjdong_nm, bonbeon, bubeon
ORDER BY 
    거래량 DESC
;

/* 동 + 본번 + 부번 으로 그룹핑한 데이터 개수 8919개*/
SELECT
    COUNT(*)
FROM
    (
    SELECT
        bjdong_nm|| ' ' ||bonbeon||DECODE(bubeon, '0', null, '-'||bubeon) AS 지번
    FROM
        SALES
    GROUP BY
        bjdong_nm, bonbeon, bubeon
    )
;

----------------------------------------------------------------------------------------------------------------

/* 동 + 본번 + 부번 으로 그룹핑 후 거래량 상위 10개 */
SELECT
    *
FROM
    (
    SELECT
        bjdong_nm|| ' ' ||bonbeon||DECODE(bubeon, '0', null, '-'||bubeon) AS 지번,count(*) as 거래량
    FROM
        SALES
    GROUP BY
        bjdong_nm, bonbeon, bubeon
    ORDER BY 
        거래량 DESC
    )
WHERE
    ROWNUM <= 10
;



/* 동 +본번 + 부번 + 구 + 아파트 로 그룹핑*/

/* 겹치는 지번이 있는것을 볼 수 있음 */
SELECT
    bjdong_nm|| ' ' ||bonbeon||DECODE(bubeon, '0', null, '-'||bubeon) AS 지번,SGG_NM||' '||BLDG_NM AS 아파트이름, count(*) as 거래량
FROM
    SALES
GROUP BY
    bjdong_nm, bonbeon, bubeon,SGG_NM, BLDG_NM
ORDER BY
    bjdong_nm, bonbeon, bubeon
;


/* 모든 데이터 평수로 변환 후 평당 거래량 조회
    
    평수로 그룹핑 결과 86행 밖에 안나오긴 함
    
*/
SELECT
    round(bldg_area/3.3)||'평' 평, COUNT(*)
FROM
    sales
GROUP BY
    round(bldg_area/3.3)
ORDER BY
    round(bldg_area/3.3)
;

INSERT INTO
    areagrade
VALUES(
    '소형', 0, 59.99999999999
);
INSERT INTO
    areagrade
VALUES(
    '중형', 60, 84.99999999999
);
INSERT INTO
    areagrade
VALUES(
    '대형', 85, 500
);


-- 면적등급 포함
SELECT
    ACC_YEAR,SGG_CD,SGG_NM,BJDONG_CD,BJDONG_NM,LAND_GBN,LAND_GBN_NM,BONBEON,BUBEON,BLDG_NM,DEAL_YMD,OBJ_AMT,BLDG_AREA,TOT_AREA,FLOOR,RIGHT_GBN,CNTL_YMD,BUILD_YEAR,HOUSE_TYPE,REQ_GBN,RDEALER_LAWDNM,grade,round(obj_amt / (bldg_area / 3.3)) as 평단가
FROM
    sales, areagrade
WHERE
    bldg_area BETWEEN lowarea AND higharea
;

-- 구별 면적등급별 평단가 조회 질의명령
SELECT
    sgg_nm, round(avg(obj_amt / (bldg_area/3.3))) as 구별평단가, grade
FROM
    sales, areagrade
WHERE
    bldg_area BETWEEN lowarea AND higharea
GROUP BY
    sgg_nm, grade
ORDER BY
    sgg_nm
;

-- 구별 평당매매가
SELECT
    sgg_nm, round(avg(obj_amt / (bldg_area / 3.3))) 평단가
FROM
    sales
GROUP BY
    sgg_nm
;

-- 연별 인구수 조회
SELECT
    *
FROM
    population
WHERE
    gu_name = '종로구'
    AND year = 2017
;

-- 연별구별거래량
SELECT
    sgg_nm, count(*), acc_year
FROM
    sales
GROUP BY
    sgg_nm, acc_year
order by
    sgg_nm
;
-- 구아파트 동지번 구아파트
SELECT
     s.sgg_nm, s.bldg_nm, round(obj_amt / (bldg_area / 3.3)) as 평단가
FROM
    sales s, (
                select
                    BJDONG_NM, BONBEON, BUBEON
                from
                    sales
                    
                where
                    (SGG_NM LIKE '%성북구' OR SGG_NM LIKE '성북구%')
                    AND (BLDG_NM LIKE '%한신' OR BLDG_NM LIKE '한신%')
                    AND ROWNUM = 1
                ) ns
WHERE
    s.bjdong_nm = ns.bjdong_nm
    AND s.bonbeon = ns.bonbeon
    AND s.bubeon = ns.bubeon
;


-- 중복된 지번, 아파트이름 표기

SELECT
    s.지번, s.아파트이름
FROM
    (
        
        SELECT
           do.지번
        FROM
            (
                SELECT
                    bjdong_nm|| ' ' ||bonbeon||DECODE(bubeon, '0', null, '-'||bubeon) AS 지번,count(*) as 거래량
                FROM
                    SALES
                GROUP BY
                    bjdong_nm, bonbeon, bubeon
                ORDER BY 
                    거래량 DESC
            ) gu,
            (
                SELECT
                    bjdong_nm|| ' ' ||bonbeon||DECODE(bubeon, '0', null, '-'||bubeon) AS 지번,SGG_NM||' '||BLDG_NM AS 아파트이름, count(*) as 거래량
                FROM
                    SALES
                GROUP BY
                    bjdong_nm, bonbeon, bubeon,SGG_NM, BLDG_NM
                ORDER BY
                    bjdong_nm, bonbeon, bubeon
            ) do
        WHERE
            do.지번 = gu.지번
        GROUP BY
            do.지번, gu.지번
        HAVING
            COUNT(*) >1
    ) ns,
    (
        SELECT
            bjdong_nm|| ' ' ||bonbeon||DECODE(bubeon, '0', null, '-'||bubeon) AS 지번,SGG_NM||' '||BLDG_NM AS 아파트이름, count(*) as 거래량
        FROM
            SALES    
        GROUP BY
            bjdong_nm, bonbeon, bubeon,SGG_NM, BLDG_NM
        ORDER BY
            bjdong_nm, bonbeon, bubeon
    ) s
WHERE
    ns.지번 = s.지번
;
