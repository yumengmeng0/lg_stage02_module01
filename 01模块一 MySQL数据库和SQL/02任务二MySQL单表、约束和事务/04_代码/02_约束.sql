/*
	约束
		约束是指对数据进行一定的限制,来保证数据的完整性 有效性 正确性
		
	常见的约束
		主键约束	primary key 
		唯一约束	unique
		非空约束	not null
		外键约束	foreign key
*/

/*
	主键约束
		特点	不可重复 唯一 非空
		作用	用来表示数据库中的每一条记录
		
	语法格式
		字段名	字段类型 primary key
*/

-- 方式1 创建一个带有主键的表
CREATE TABLE emp2(
	eid INT PRIMARY KEY,
	ename VARCHAR(20),
	sex CHAR(1)
);

DESC emp2;

-- 方式2 创建
DROP TABLE emp2; -- 删除表

CREATE TABLE emp2(
	eid INT,
	ename VARCHAR(20),
	sex CHAR(1),
	PRIMARY KEY(eid) -- 指定eid为主键
);

-- 方式3 创建表之后 再添加主键
CREATE TABLE emp2(
	eid INT,
	ename VARCHAR(20),
	sex CHAR(1)
);

-- 通过DDL语句 添加主键约束
ALTER TABLE emp2 ADD PRIMARY KEY(eid);


-- 删除主键 DDL语句
ALTER TABLE emp2 DROP PRIMARY KEY;

/*
	主键的自增
		关键字:  auto_increment 主键的自动增长(字段类型必须是 整数类型)
*/

-- 创建主键自增的表
CREATE TABLE emp2(
	-- 主键自增
	eid INT PRIMARY KEY AUTO_INCREMENT,
	ename VARCHAR(20),
	sex CHAR(1)
);
-- 添加数据 观察主键变化
INSERT INTO emp2(ename,sex) VALUES('张三','男');
INSERT INTO emp2(ename,sex) VALUES('李四','男');
INSERT INTO emp2 VALUES(NULL,'翠花','女');
INSERT INTO emp2 VALUES(NULL,'艳秋','女');

-- 修改自增起始值 

-- 重新创建自增主键的表, 自定义自增的其实位置
CREATE TABLE emp2(
	eid INT PRIMARY KEY AUTO_INCREMENT,
	ename VARCHAR(20),
	sex CHAR(1)
)AUTO_INCREMENT=100;

/*
	DELETE和TRUNCATE对自增长的影响
	
	delete 删除表中所有数据, 将表中的数据逐条删除.
	truncate 删除表中的所有数据, 是将整个表删除,然后再创建一个结构相同表.
*/

-- delete 方式删除所有数据 
DELETE FROM emp2; -- delete 删除对自增是没有影响

INSERT INTO emp2(ename,sex) VALUES('张百万','男'); -- 102
INSERT INTO emp2(ename,sex) VALUES('艳秋','女'); -- 103


-- truncate 删除所有数据
TRUNCATE TABLE emp2; -- 自增从1开始

INSERT INTO emp2(ename,sex) VALUES('张百万','男'); -- 1
INSERT INTO emp2(ename,sex) VALUES('艳秋','女'); -- 2


/*
	非空约束
		特点 表中某一列不予许为空
		
	语法格式
		字段名 字段类型 not null
*/

CREATE TABLE emp2(
	eid INT PRIMARY KEY AUTO_INCREMENT,
	-- 将 ename字段 添加了 非空约束
	ename VARCHAR(20) NOT NULL,
	sex CHAR(1)
);

/*
	唯一约束
		特点: 表中的某一列不能够重复 (对null值 不做唯一判断)

	语法格式
		字段名 字段类型 unique
*/
-- 创建 emp3表 为ename 字段添加 唯一约束
CREATE TABLE emp3(
	eid INT PRIMARY KEY ,
	ename VARCHAR(20) UNIQUE,
	sex CHAR(1)
);

-- 测试唯一约束
INSERT INTO emp3 VALUES(1,'张百万','女');

-- Duplicate entry '张百万' for key 'ename' 不能重复
INSERT INTO emp3 VALUES(2,'张百万','女');

-- 唯一约束的值 可以为 null
INSERT INTO emp3 VALUES(2,NULL,'女');


-- 主键约束和唯一约束的区别
	-- 1.主键约束 他是唯一且不能为空的
	-- 2.唯一约束 唯一,但是可以为空
	-- 3.一个表中只能有一个主键,但是可以有多个唯一约束

-- 外键约束 多表中再学习

/*
	默认值
		特点 用来指定 某一列的默认值
		
	语法格式
		字段名 字段类型 default 默认值
*/
--  创建 emp4表, 指定 sex默认为 女
CREATE TABLE emp4(
	eid INT PRIMARY KEY,
	ename VARCHAR(20),
	sex CHAR(1) DEFAULT '女'
);

INSERT INTO emp4(eid,ename) VALUES(1,'杨幂');
INSERT INTO emp4(eid,ename) VALUES(2,'柳岩');

-- 不使用默认值
INSERT INTO emp4(eid,ename,sex) VALUES(3,'蔡徐坤','男');









































