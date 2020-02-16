-- In SQL92 DATE - DATE = INTEGER
-- DATE - INTERVAL = DATE
-- 1.	查询2011年进校年龄大于20岁的男学生的学号与姓名。
SELECT *
FROM s
WHERE csrq < DATE '2011-09-01' - INTERVAL '20 YEARS';

-- 2.	检索刘晓明不学的课程的课程号。
SELECT kh
FROM c
WHERE kh NOT IN (
    SELECT kh
    FROM e
    WHERE xh = (
        SELECT xh
        FROM s
        WHERE xm = '刘晓明'
    )
);

-- 3.	检索马小红老师所授课程的学年，学期，课程号，上课时间。
SELECT *
FROM o
WHERE gh = (
    SELECT gh
    FROM t
    WHERE xm = '马小红'
);

-- 4.	查询计算机学院男生总评成绩及格、教授开设的课程的课程号、课名、开课教师姓名，按开课教师升序，课程号降序排序。
SELECT plan.kh, plan.gh, teacher.xm
FROM o plan,
     t teacher
WHERE (plan.kh, plan.gh) IN (
    SELECT kh, gh
    FROM e
    WHERE zpcj > 60
      AND xh IN (
        SELECT xh
        FROM s
        WHERE s.xb = '男'
    )
)
  AND plan.gh = teacher.gh
ORDER BY teacher.gh, plan.kh DESC;

-- 5.	检索学号比张颖同学大，年龄比张颖同学小的同学学号、姓名。
SELECT xh, xm
FROM s
WHERE xh > (
    SELECT xh
    FROM s
    WHERE xm = '张颖'
)
  AND csrq > (
    SELECT csrq
    FROM s
    WHERE xm = '张颖'
);

-- 6.	检索同时选修了“08305001”和“08305002”的学生学号和姓名。
SELECT DISTINCT student.xh, student.xm
FROM s student
         INNER JOIN (SELECT xh FROM e WHERE kh = '08305001') e1
                    ON student.xh = e1.xh
         INNER JOIN (SELECT xh FROM e WHERE kh = '08305002') e2
                    ON student.xh = e2.xh;
