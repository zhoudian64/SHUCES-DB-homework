CREATE TABLE test_index
(
    id    INTEGER,
    value FLOAT
);

CREATE OR REPLACE FUNCTION ten_million_cols() RETURNS void AS
$$
DECLARE
    id  INTEGER;
    var FLOAT;
BEGIN
    id = 0;
    WHILE (id < 10000000)
        LOOP
            var = (id % 10) * 0.1;
            INSERT INTO test_index(id, value)
            VALUES (id, var);
            id = id + 1;
        END LOOP;
END;
$$ LANGUAGE plpgsql;

-- homework.public> do
--                  $$
--                      begin
--                          perform ten_million_cols();
--                      end
--                  $$
-- [2020-02-16 14:32:43] completed in 58 s 129 ms
do
$$
    begin
        perform ten_million_cols();
    end
$$;

-- [2020-02-16 14:36:29] 500 rows retrieved starting from 1 in 78 ms (execution: 13 ms, fetching: 65 ms)
SELECT *
FROM test_index
WHERE value > 0.5
  AND value < 0.8;

CREATE INDEX value_idx ON test_index (value);

-- [2020-02-16 15:23:04] 500 rows retrieved starting from 1 in 62 ms (execution: 10 ms, fetching: 52 ms)
SELECT *
FROM test_index
WHERE value > 0.5
  AND value < 0.8;

-- 2.	查询每个学生选课情况（包括没有选修课程的学生）。
SELECT *
FROM s
         LEFT JOIN e ON s.xh = e.xh

-- 3.	检索所有课程都选修的的学生的学号与姓名。
SELECT xh, xm
FROM s
WHERE xh in (
    SELECT xh
    FROM e
    GROUP BY xh
    HAVING count(kh) = (
        SELECT count(*)
        FROM c
    )
);

-- 4.	检索选修课程包含1106同学所学全部课程的学生学号和姓名。
-- 可删除 测试
-- 1107	2012-2013秋季                                                                                         	08305001	0103	90	90	90.00
SELECT xh, xm
FROM s
WHERE xh in (
    SELECT xh
    FROM e
    WHERE kh IN (
        SELECT kh
        FROM e
        WHERE xh = '1106'
    ));

-- 5.	查询每门课程中分数最高的学生学号和学生姓名。
SELECT xh, xm
FROM s
WHERE xh IN (
    SELECT xh
    FROM e
    WHERE (kh, zpcj) IN (
        SELECT kh, MAX(zpcj)
        FROM e
        GROUP BY (kh)
    ));

-- 6.	查询年龄小于本学院平均年龄，所有课程总评成绩都高于所选课程平均总评成绩的学生学号、姓名和平均总评成绩，按年龄排序。
SELECT s.xh, xm, AVG(zpcj)
FROM s,
     e
WHERE CURRENT_DATE - csrq < (
    SELECT AVG(CURRENT_DATE - csrq) AS AVG_AGE
    FROM s)
  AND s.xh NOT IN (
--     SELECT xh, kh, zpcj
    SELECT xh
    FROM e zpcj_xh_kh
    WHERE zpcj < (
        SELECT AVG_ZPCJ
        FROM (
                 SELECT kh, AVG(zpcj) as AVG_ZPCJ
                 FROM e avg_e
                 WHERE avg_e.kh = zpcj_xh_kh.kh
                 GROUP BY kh
             ) AS avg_multi_col
    )
)
  AND s.xh = e.xh
GROUP BY (s.xh)
ORDER BY csrq
;
