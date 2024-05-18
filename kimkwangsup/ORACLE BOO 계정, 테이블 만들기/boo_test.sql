
/* �� + ����Ʈ �� �׷��� �� �Ͱ� �� + ���� + ���� ���� �׷��� �� ���� ������ �ٸ�
    �� + ���� + �ι� ���� �׷��� �� �������� ������ �� �������� �з��� �̰��� ������
    �ϴ°��� �¾� ����
    
    �ٵ� ����ڿ��� �Է��� ??�� ???-?? �̷��� �Է� �϶�� �� �� ����.. 
    
    Ÿ�� �縮��, Ÿ�� �縮��1, Ÿ�� �縮�� 1�� �̷������� ����ȭ ���� �ʰ� �Ű� �Ǿ��ִ� �͵��� ���Ƽ� ���� �� �ؾ��ҵ�
    
------------------------------------------------------

�������� �˻� �� ����Ʈ �� �ŷ����� ���� ���� �������� ����Ʈ��
����ڿ��� ������ ����Ʈ�� ��� �ϵ� �ŷ����� �������� �˻��� �ŷ��� ��θ� ���������

ex)
    ������ 101-3 / ���ı� ��Ű�Ծ���Ʈ 1��/ 2��
    ������ 101-3 / ���ı� ��Ű�Ծ���Ʈ1��(���Ⱑ ��� �ٸ� ��..)/ 1��
    
    ��ǥ ����Ʈ �̸��� > ���ı� ��Ű�Ծ���Ʈ 1��
    �ŷ����� > 3��
    
    �̷��� ǥ�� �Ǿ����
    

-------------------------------------------------------


*/


/* �� + ����Ʈ �� �׷��� �� �ŷ��� ��������*/
SELECT
    SGG_NM||' '||BLDG_NM AS ����Ʈ�̸�, count(*) as �ŷ���
FROM
    SALES
GROUP BY
    SGG_NM, BLDG_NM
ORDER BY 
    �ŷ��� DESC
;

/* �� + ����Ʈ �� �׷����� ������ ���� 9425��*/
SELECT
    COUNT(*)
FROM
    (
    SELECT
        SGG_NM||' '||BLDG_NM AS ����Ʈ�̸�
    FROM
        SALES
    GROUP BY
        SGG_NM, BLDG_NM
    )
;



/* �� + ���� + �ι� ���� �׷��� �� �ŷ��� ��������*/
SELECT
    bjdong_nm|| ' ' ||bonbeon||DECODE(bubeon, '0', null, '-'||bubeon) AS ����,count(*) as �ŷ���
FROM
    SALES
GROUP BY
    bjdong_nm, bonbeon, bubeon
ORDER BY 
    �ŷ��� DESC
;

/* �� + ���� + �ι� ���� �׷����� ������ ���� 8919��*/
SELECT
    COUNT(*)
FROM
    (
    SELECT
        bjdong_nm|| ' ' ||bonbeon||DECODE(bubeon, '0', null, '-'||bubeon) AS ����
    FROM
        SALES
    GROUP BY
        bjdong_nm, bonbeon, bubeon
    )
;

----------------------------------------------------------------------------------------------------------------

/* �� + ���� + �ι� ���� �׷��� �� �ŷ��� ���� 10�� */
SELECT
    *
FROM
    (
    SELECT
        bjdong_nm|| ' ' ||bonbeon||DECODE(bubeon, '0', null, '-'||bubeon) AS ����,count(*) as �ŷ���
    FROM
        SALES
    GROUP BY
        bjdong_nm, bonbeon, bubeon
    ORDER BY 
        �ŷ��� DESC
    )
WHERE
    ROWNUM <= 10
;



/* �� +���� + �ι� + �� + ����Ʈ �� �׷���*/

/* ��ġ�� ������ �ִ°��� �� �� ���� */
SELECT
    bjdong_nm|| ' ' ||bonbeon||DECODE(bubeon, '0', null, '-'||bubeon) AS ����,SGG_NM||' '||BLDG_NM AS ����Ʈ�̸�, count(*) as �ŷ���
FROM
    SALES
GROUP BY
    bjdong_nm, bonbeon, bubeon,SGG_NM, BLDG_NM
ORDER BY
    bjdong_nm, bonbeon, bubeon
;


/* ��� ������ ����� ��ȯ �� ��� �ŷ��� ��ȸ
    
    ����� �׷��� ��� 86�� �ۿ� �ȳ����� ��
    
*/
SELECT
    round(bldg_area/3.3)||'��' ��, COUNT(*)
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


-- ������� ����
SELECT
    ACC_YEAR,SGG_CD,SGG_NM,BJDONG_CD,BJDONG_NM,LAND_GBN,LAND_GBN_NM,BONBEON,BUBEON,BLDG_NM,DEAL_YMD,OBJ_AMT,BLDG_AREA,TOT_AREA,FLOOR,RIGHT_GBN,CNTL_YMD,BUILD_YEAR,HOUSE_TYPE,REQ_GBN,RDEALER_LAWDNM,grade,round(obj_amt / (bldg_area / 3.3)) as ��ܰ�
FROM
    sales, areagrade
WHERE
    bldg_area BETWEEN lowarea AND higharea
;

-- ���� ������޺� ��ܰ� ��ȸ ���Ǹ��
SELECT
    sgg_nm, round(avg(obj_amt / (bldg_area/3.3))) as ������ܰ�, grade
FROM
    sales, areagrade
WHERE
    bldg_area BETWEEN lowarea AND higharea
GROUP BY
    sgg_nm, grade
ORDER BY
    sgg_nm
;

-- ���� ���ŸŰ�
SELECT
    sgg_nm, round(avg(obj_amt / (bldg_area / 3.3))) ��ܰ�
FROM
    sales
GROUP BY
    sgg_nm
;

-- ���� �α��� ��ȸ
SELECT
    *
FROM
    population
WHERE
    gu_name = '���α�'
    AND year = 2017
;

-- ���������ŷ���
SELECT
    sgg_nm, count(*), acc_year
FROM
    sales
GROUP BY
    sgg_nm, acc_year
order by
    sgg_nm
;