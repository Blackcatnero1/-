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
    '1억 미만', 0, 9999
);
INSERT INTO
    amtgrade
VALUES(
    '1억 이상 3억 미만', 10000, 29999
);
INSERT INTO
    amtgrade
VALUES(
    '3억 이상 5억 미만', 30000, 49999
);
INSERT INTO
    amtgrade
VALUES(
    '5억 이상 7억 미만', 50000, 69999
);
INSERT INTO
    amtgrade
VALUES(
    '7억 이상 10억 미만', 70000, 99999
);
INSERT INTO
    amtgrade
VALUES(
    '10억 이상 20억 미만', 100000, 199999
);
INSERT INTO
    amtgrade
VALUES(
    '20억 이상', 200000, 999999
);
