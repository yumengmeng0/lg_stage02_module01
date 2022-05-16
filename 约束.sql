/*
	约束：对数据进行一定的限制，来保证数据的完整性，有效性，完整性
	常见约束：
		主键约束 primary key
		唯一约束 unique
		非空约束 not null
		外键约束 foreign key
		
		
*/

/*
	主键约束：
		特点：不可重复，唯一，非空
		作用：用来表示数据库中的每一条记录
	语法格式：
		字段名 字段类型 primary key

*/

-- 方式1 创建一个带主键的表
CREATE TABLE emp2(
	eid INT PRIMARY KEY,
	ename VARCHAR(20),
	sex CHAR(1)
);

-- 方式2 指定
CREATE TABLE emp3(
	eid INT PRIMARY KEY,
	ename VARCHAR(20),
	sex CHAR(1),
	PRIMARY KEY(eid)
);

-- 方式3 创建表之后再添加主键，通过DDL语句添加主键
CREATE TABLE emp4(
	eid INT,
	ename VARCHAR(20),
	sex CHAR(1)
);

-- 添加主键
ALTER TABLE emp4 ADD PRIMARY KEY(eid);

-- 删除主键
ALTER TABLE emp4 DROP PRIMARY KEY;


/*
	主键（必须是整型）自增：auto_increment
*/

CREATE TABLE emp5(
	eid INT PRIMARY KEY AUTO_INCREMENT,
	ename VARCHAR(20),
	sex CHAR(1)
);

INSERT INTO emp5(ename,sex) VALUES('张三','男');
INSERT INTO emp5(ename,sex) VALUES('李四','男');
INSERT INTO emp5(ename,sex) VALUES('小兰','女');

-- 修改自增的起始值
CREATE TABLE emp6(
	eid INT PRIMARY KEY AUTO_INCREMENT ,
	ename VARCHAR(20),
	sex CHAR(1)
)AUTO_INCREMENT=100; # 主键自增起始值是100

INSERT INTO emp6(ename,sex) VALUES('张三','男');
INSERT INTO emp6(ename,sex) VALUES('李四','男');
INSERT INTO emp6(ename,sex) VALUES('小兰','女');

/*
	delete和truncate对自增的影响
	delete删除对自增没有影响，删除后继续编号
	
*/


-- delete方式删除所有数据
DELETE FROM emp6;

INSERT INTO emp6(ename,sex) VALUES('张三','男'); 
INSERT INTO emp6(ename,sex) VALUES('李四','男');
INSERT INTO emp6(ename,sex) VALUES('小兰','女');

-- 插入后eid从103开始

-- truncate删除数据
TRUNCATE TABLE emp6; -- 自增从1开始


/*
	非空约束：某一列不允许为空
*/

/*
	唯一约束：表中的某一列不能重复（对null值不做唯一判断）
*/

/*
	主键约束与唯一约束的区别:
	1.主键约束唯一且不能为空
	2.唯一约束唯一可为空
	3.表中只能有一个主键
*/

/*
	外键约束（多表）
*/

/*
	默认值
	语法格式：
		字段名 字段类型 default 默认值;
*/
