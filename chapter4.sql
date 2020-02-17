-- 1.	建立计算机学院总评不及格成绩学生的视图，包括学生学号、姓名、性别、手机、所选课程和成绩。
CREATE OR REPLACE VIEW failed_student AS
SELECT s.xh, s.xm, s.xb, s.sjhm, c.km, e.zpcj
FROM s
         INNER JOIN e
                    ON s.xh = e.xh
         INNER JOIN c
                    ON e.zpcj < 60 AND c.kh = e.kh;

SELECT *
FROM failed_student;

-- 2.	在E表中插入记录，把每个学生没学过的课程都插入到E表中，使得每个学生都选修每门课。
INSERT INTO e (xh, xq, kh)
SELECT DISTINCT s.xh, o.xq, o.kh
FROM s,
     o
WHERE NOT EXISTS(
        SELECT xh, xq, kh
        FROM e
        WHERE e.xh = s.xh
          AND e.kh = o.kh
    );

-- 3.	求年龄大于所有女同学年龄的男学生姓名和年龄。
SELECT xm, CURRENT_DATE - csrq
FROM s
WHERE xb = '男'
  AND CURRENT_DATE - csrq > (
    SELECT AVG(CURRENT_DATE - csrq)
    FROM s
    WHERE xb = '女');

-- 4.	在E表中修改08305001课程的平时成绩，若成绩小于等于75分时提高5%，若成绩大于75分时提高4%。
UPDATE e
SET pscj = pscj * 1.05
WHERE pscj <= 75
  AND kh = '08305001';
UPDATE e
SET pscj = pscj / 1.05
WHERE pscj <= 75 * 1.05
  AND kh = '08305001';

UPDATE e
SET pscj = pscj * 1.04
WHERE pscj > 75
  AND kh = '08305001'
  AND pscj < 75 * 1.04;
UPDATE e
SET pscj = pscj / 1.04
WHERE pscj > 75
  AND kh = '08305001'
  AND pscj < 75 * 1.04;

-- 5.	删除没有开课的学院。
DELETE
FROM d
WHERE d.yxh IN
      (
          SELECT yxh
          FROM c
          WHERE (
                        c.kh NOT IN (
                        SELECT kh
                        FROM o
                    )
                    )
      );

-- 6.	查询优、良、中、及格、不及格学生人数
SELECT COUNT(DISTINCT (E_100.xh, E_100.kh)) as 优,
       COUNT(DISTINCT (E_90.xh, E_90.kh))   as 良,
       COUNT(DISTINCT (E_80.xh, E_80.kh))   AS 中,
       COUNT(DISTINCT (E_70.xh, E_70.kh))   AS 及格,
       COUNT(DISTINCT (E_60.xh, E_60.kh))   as 不及格
-- SELECt *
FROM (SELECT xh, kh FROM e WHERE zpcj < 60) AS E_60,
     (SELECT xh, kh FROM e WHERE zpcj >= 60 AND zpcj < 70) AS E_70,
     (SELECT xh, kh FROM e WHERE zpcj >= 70 AND zpcj < 80) AS E_80,
     (SELECT xh, kh FROM e WHERE zpcj >= 80 AND zpcj < 90) AS E_90,
     (SELECT xh, kh FROM e WHERE zpcj >= 90 AND zpcj <= 100) AS E_100;

SELECT COUNT(E_100.xh) as 优秀
FROM (SELECT xh FROM e WHERE zpcj >= 90 AND zpcj < 100) AS E_100




