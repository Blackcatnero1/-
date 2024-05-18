
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



