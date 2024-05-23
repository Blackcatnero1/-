CREATE TABLE amtgrade(
    grade VARCHAR2(30 CHAR)
        CONSTRAINT AG_GD_NN NOT NULL,
    lowamt NUMBER
        CONSTRAINT AG_LOW_NN NOT NULL,
    highamt NUMBER
        CONSTRAINT AG_HIGH_NN NOT NULL
);
INSERT INTO
    amtgrade
VALUES(
    '1�� �̸�', 0, 9999
);
INSERT INTO
    amtgrade
VALUES(
    '1�� �̻� 3�� �̸�', 10000, 29999
);
INSERT INTO
    amtgrade
VALUES(
    '3�� �̻� 5�� �̸�', 30000, 49999
);
INSERT INTO
    amtgrade
VALUES(
    '5�� �̻� 7�� �̸�', 50000, 69999
);
INSERT INTO
    amtgrade
VALUES(
    '7�� �̻� 10�� �̸�', 70000, 99999
);
INSERT INTO
    amtgrade
VALUES(
    '10�� �̻� 20�� �̸�', 100000, 199999
);
INSERT INTO
    amtgrade
VALUES(
    '20�� �̻�', 200000, 999999
);
