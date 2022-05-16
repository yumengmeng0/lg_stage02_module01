/*
	DML 增删改
	增加：insert into 表名 values(字段名1,字段名2...)
*/

DROP DATABASE IF EXISTS school;
CREATE DATABASE school CHARACTER SET utf8;

USE school;

-- 创建学生表
CREATE TABLE student(
	sid INT,
	sname VARCHAR(20),
	age INT,
	sex CHAR(1),
	address VARCHAR(40)
);


-- 向学生表中插入数据

-- 方式1：插入全部字段，将所有字段名都写出来
INSERT INTO student(sid,sname,age,sex,address)  VALUES (1001,'张三',18,'男','河南');

-- 方式2：插入全部字段，不写字段名
INSERT INTO student VALUES (1002,'李四',18,'男','河南');

-- 方式3：插入指定字段

INSERT INTO student(sid,sname) VALUES (1003,'王五');

/*
	注意事项：
		插入varchar\char\date类型，必须用单引号或双引号
		插入空值可以null或不写
*/

/*
	修改数据
		update 表名 set 列名 = 值;
		update 表名 set 列名 = 值 [where 条件表达式：字段名 = 值]

*/

UPDATE student SET age = 22 WHERE sid = 1003;


/*
	删除数据
		delete from 表名;
		delete from 表名 [where 条件];
*/

DELETE FROM student WHERE sid = 1002;

-- 删除表中所有数据（不推荐，逐条删除效率低）
DELETE FROM student;

-- 删除表中所有数据（推荐，先删除整张表，再创建）（TRUNCATE截断; 截短，缩短，删节）
TRUNCATE TABLE student;



