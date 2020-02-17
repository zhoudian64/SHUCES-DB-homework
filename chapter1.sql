-- FULLY FULFIL SQL92
-- CREATE TABLE
CREATE TABLE D
(
    yxh  CHARACTER(2) NOT NULL,
    mc   CHARACTER(50),
    dz   CHARACTER(100),
    lxdh DECIMAL(8),
    PRIMARY KEY (yxh)
);
CREATE TABLE S
(
    xh   CHARACTER(4) NOT NULL,
    xm   CHARACTER(50),
    xb   CHARACTER(5),
    csrq DATE,
    jg   CHARACTER(80),
    sjhm DECIMAL(11),
    yxh  CHARACTER(2),
    PRIMARY KEY (xh),
    FOREIGN KEY (yxh) REFERENCES D (yxh)
);
CREATE TABLE T
(
    gh   CHARACTER(4) NOT NULL,
    xm  CHARACTER(50),
    xb   CHARACTER(5),
    csrq DATE,
    xl   CHARACTER(50),
    jbgz DECIMAL(10, 0),
    yxh  CHARACTER(2),
    PRIMARY KEY (gh),
    FOREIGN KEY (yxh) REFERENCES D (yxh)
);
CREATE TABLE C
(
    kh  CHARACTER(8) NOT NULL,
    km  CHARACTER(100),
    xf  INTEGER,
    xs  INTEGER,
    yxh CHARACTER(2),
    PRIMARY KEY (kh),
    FOREIGN KEY (yxh) REFERENCES D (yxh) ON DELETE CASCADE
);
CREATE TABLE O
(
    xq   CHARACTER(100) NOT NULL,
    kh   CHARACTER(8),
    gh   CHARACTER(4),
    sksj CHARACTER(100),
    PRIMARY KEY (xq, kh, gh),
    FOREIGN KEY (kh) REFERENCES C (kh),
    FOREIGN KEY (gh) REFERENCES T (gh)
);
CREATE TABLE E
(
    xh   CHARACTER(4),
    xq   CHARACTER(100),
    kh   CHARACTER(8),
    gh   CHARACTER(4),
    pscj DECIMAL(3),
    kscj DECIMAL(3),
    zpcj DECIMAL(5, 2),
    PRIMARY KEY (xh, xq, kh),
    FOREIGN KEY (xq, kh, gh)
        REFERENCES O (xq, kh, gh),
    CHECK (pscj BETWEEN 0 and 100),
    CHECK (kscj BETWEEN 0 and 100),
    CHECK (zpcj BETWEEN 0 and 100)
);
CREATE INDEX idx1 ON S (yxh ASC, xm DESC);
CREATE INDEX idx2 ON C (km);

-- INSERT DATA
INSERT INTO d (yxh, mc, dz, lxdh) VALUES ('01', '计算机学院', '上大东校区三号楼', 65347567);
INSERT INTO d (yxh, mc, dz, lxdh) VALUES ('02', '通讯学院', '上大东校区二号楼', 65341234);
INSERT INTO d (yxh, mc, dz, lxdh) VALUES ('03', '材料学院', '上大东校区四号楼', 65347890);

INSERT INTO s (xh, xm, xb, csrq, jg, sjhm, yxh) VALUES ('1101', '李明', '男', '1993-03-06', '上海', 13613005486, '02');
INSERT INTO s (xh, xm, xb, csrq, jg, sjhm, yxh) VALUES ('1102', '刘晓明', '男', '1992-12-08', '安徽', 18913457890, '01');
INSERT INTO s (xh, xm, xb, csrq, jg, sjhm, yxh) VALUES ('1103', '张颖', '女', '1993-01-05', '江苏', 18826490423, '01');
INSERT INTO s (xh, xm, xb, csrq, jg, sjhm, yxh) VALUES ('1104', '刘晶晶', '女', '1994-11-06', '上海', 13331934111, '01');
INSERT INTO s (xh, xm, xb, csrq, jg, sjhm, yxh) VALUES ('1105', '刘成刚', '男', '1991-06-07', '上海', 18015872567, '01');
INSERT INTO s (xh, xm, xb, csrq, jg, sjhm, yxh) VALUES ('1106', '李二丽', '女', '1993-05-04', '江苏', 18107620945, '01');
INSERT INTO s (xh, xm, xb, csrq, jg, sjhm, yxh) VALUES ('1107', '张晓峰', '男', '1992-08-16', '浙江', 13912341078, '01');

INSERT INTO t (gh, xm, xb, csrq, xl, jbgz, yxh) VALUES ('0101', '陈迪茂', '男', '1973-03-06', '副教授', 3567, '01');
INSERT INTO t (gh, xm, xb, csrq, xl, jbgz, yxh) VALUES ('0102', '马小红', '女', '1972-12-08', '讲师', 2845, '01');
INSERT INTO t (gh, xm, xb, csrq, xl, jbgz, yxh) VALUES ('0201', '张心颖', '女', '1960-01-05', '教授', 4200, '02');
INSERT INTO t (gh, xm, xb, csrq, xl, jbgz, yxh) VALUES ('0103', '吴宝钢', '男', '1980-11-06', '讲师', 2554, '01');

INSERT INTO c (kh, km, xf, xs, yxh) VALUES ('08305001', '离散数学', 4, 40, '01');
INSERT INTO c (kh, km, xf, xs, yxh) VALUES ('08305002', '数据库原理', 4, 50, '01');
INSERT INTO c (kh, km, xf, xs, yxh) VALUES ('08305003', '数据结构', 4, 50, '01');
INSERT INTO c (kh, km, xf, xs, yxh) VALUES ('08305004', '系统结构', 6, 60, '01');
INSERT INTO c (kh, km, xf, xs, yxh) VALUES ('08301001', '分子物理学', 4, 40, '03');
INSERT INTO c (kh, km, xf, xs, yxh) VALUES ('08302001', '通信学', 3, 30, '02');

INSERT INTO o (xq, kh, gh, sksj) VALUES ('2012-2013秋季', '08305001', '0103', '星期三5-8
');
INSERT INTO o (xq, kh, gh, sksj) VALUES ('2012-2013冬季', '08305002', '0101', '星期三1-4
');
INSERT INTO o (xq, kh, gh, sksj) VALUES ('2012-2013冬季', '08305002', '0102', '星期三1-4
');
INSERT INTO o (xq, kh, gh, sksj) VALUES ('2012-2013冬季', '08305002', '0103', '星期三1-4
');
INSERT INTO o (xq, kh, gh, sksj) VALUES ('2012-2013冬季', '08305003', '0102', '星期五5-8
');
INSERT INTO o (xq, kh, gh, sksj) VALUES ('2013-2014秋季', '08305004', '0101', '星期二1-4
');
INSERT INTO o (xq, kh, gh, sksj) VALUES ('2013-2014秋季', '08305001', '0102', '星期一5-8
');
INSERT INTO o (xq, kh, gh, sksj) VALUES ('2013-2014冬季', '08302001', '0201', '星期一5-8
');

INSERT INTO e (xh, xq, kh, gh, pscj, kscj, zpcj) VALUES ('1101', '2012-2013秋季', '08305001', '0103', 60, 60, 60.00);
INSERT INTO e (xh, xq, kh, gh, pscj, kscj, zpcj) VALUES ('1102', '2012-2013秋季', '08305001', '0103', 87, 87, 87.00);
INSERT INTO e (xh, xq, kh, gh, pscj, kscj, zpcj) VALUES ('1102', '2012-2013冬季', '08305002', '0101', 82, 82, 82.00);
INSERT INTO e (xh, xq, kh, gh, pscj, kscj, zpcj) VALUES ('1102', '2013-2014秋季', '08305004', '0101', null, null, null);
INSERT INTO e (xh, xq, kh, gh, pscj, kscj, zpcj) VALUES ('1103', '2012-2013秋季', '08305001', '0103', 56, 56, 56.00);
INSERT INTO e (xh, xq, kh, gh, pscj, kscj, zpcj) VALUES ('1103', '2012-2013冬季', '08305002', '0102', 75, 75, 75.00);
INSERT INTO e (xh, xq, kh, gh, pscj, kscj, zpcj) VALUES ('1103', '2012-2013冬季', '08305003', '0102', 84, 84, 84.00);
INSERT INTO e (xh, xq, kh, gh, pscj, kscj, zpcj) VALUES ('1103', '2013-2014秋季', '08305001', '0102', null, null, null);
INSERT INTO e (xh, xq, kh, gh, pscj, kscj, zpcj) VALUES ('1103', '2013-2014秋季', '08305004', '0101', null, null, null);
INSERT INTO e (xh, xq, kh, gh, pscj, kscj, zpcj) VALUES ('1104', '2012-2013秋季', '08305001', '0103', 74, 74, 74.00);
INSERT INTO e (xh, xq, kh, gh, pscj, kscj, zpcj) VALUES ('1104', '2013-2014冬季', '08302001', '0201', null, null, null);
INSERT INTO e (xh, xq, kh, gh, pscj, kscj, zpcj) VALUES ('1106', '2012-2013秋季', '08305001', '0103', 85, 85, 85.00);
INSERT INTO e (xh, xq, kh, gh, pscj, kscj, zpcj) VALUES ('1106', '2012-2013冬季', '08305002', '0103', 66, 66, 66.00);
INSERT INTO e (xh, xq, kh, gh, pscj, kscj, zpcj) VALUES ('1107', '2012-2013秋季', '08305001', '0103', 90, 90, 90.00);
INSERT INTO e (xh, xq, kh, gh, pscj, kscj, zpcj) VALUES ('1107', '2012-2013冬季', '08305003', '0102', 79, 79, 79.00);