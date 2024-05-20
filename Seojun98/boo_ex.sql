
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



