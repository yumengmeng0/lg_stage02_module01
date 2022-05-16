-- 创建部门表
-- 一方,主表
CREATE TABLE department(
	 id INT PRIMARY KEY AUTO_INCREMENT,   
	 dep_name VARCHAR(30),	
	 dep_location VARCHAR(30)
);

-- 创建员工表
-- 多方 ,从表
CREATE TABLE employee(
	eid INT PRIMARY KEY AUTO_INCREMENT,
	ename VARCHAR(20),
	age INT,
	dept_id INT
);


-- 添加2个部门 
INSERT INTO department VALUES(NULL, '研发部','广州'),(NULL, '销售部', '深圳'); 
SELECT * FROM department; 

-- 添加员工,dep_id表示员工所在的部门 
INSERT INTO employee (ename, age, dept_id) VALUES ('张百万', 20, 1); 
INSERT INTO employee (ename, age, dept_id) VALUES ('赵四', 21, 1); 
INSERT INTO employee (ename, age, dept_id) VALUES ('广坤', 20, 1); 
INSERT INTO employee (ename, age, dept_id) VALUES ('小斌', 20, 2); 
INSERT INTO employee (ename, age, dept_id) VALUES ('艳秋', 22, 2); 
INSERT INTO employee (ename, age, dept_id) VALUES ('大玲子', 18, 2); 

SELECT * FROM employee;

-- 插入一条 不存在部门的数据
INSERT INTO employee (ename,age,dept_id) VALUES('无名',35,3);


/*
	外键约束
		作用: 外键约束可以让两张表之间产生有一个对应的关,从而保证了主从表引用的完整性
	
	外键
		外键指的是在从表中与主表的主键对应的字段
		
	主表和从表
		主表 主键id所在的表 ,一的一方
		从表 外键字段所在的表,多的一方
	
	添加外键约束的语法格式
		1.创建表的时候添加外键
		create table 表名(
			字段...
			[constraint] [外键约束名] foreign key(外键字段名) references 主表(主键字段)
		);
	
*/

-- 创建员工表 添加外键
CREATE TABLE employee(
	eid INT PRIMARY KEY AUTO_INCREMENT,
	ename VARCHAR(20),
	age INT,
	dept_id INT, -- 外键字段 指向了主表的主键
	-- 添加外键约束
	CONSTRAINT emp_dept_fk FOREIGN KEY(dept_id) REFERENCES department(id)
);

-- 正常添加数据 (从表外键 对应主表主键)
INSERT INTO employee (ename, age, dept_id) VALUES ('张百万', 20, 1); 
INSERT INTO employee (ename, age, dept_id) VALUES ('赵四', 21, 1); 
INSERT INTO employee (ename, age, dept_id) VALUES ('广坤', 20, 1); 
INSERT INTO employee (ename, age, dept_id) VALUES ('小斌', 20, 2); 
INSERT INTO employee (ename, age, dept_id) VALUES ('艳秋', 22, 2); 
INSERT INTO employee (ename, age, dept_id) VALUES ('大玲子', 18, 2); 

-- 插入一条错误的数据
-- 添加外键约束之后 就会产生一个强制的外键约束检查 保证数据的完整性和一致性
INSERT INTO employee (ename, age, dept_id) VALUES ('错误', 18, 3); 


/*
	删除外键约束
	语法格式
		alter table 从表 drop foreign key 外键约束的名称

*/

-- 删除 employee表中 外键
ALTER TABLE employee DROP FOREIGN KEY emp_dept_fk;

-- 创建表之后添加外键
-- 语法格式 alter table 从表 add CONSTRAINT emp_dept_fk FOREIGN KEY(dept_id) REFERENCES department(id)

-- 简写 不写外键约束名 自动生成的外键约束 employee_ibfk_1
ALTER TABLE employee ADD FOREIGN KEY(dept_id) REFERENCES department(id)

/*
	外键约束的注意事项
		1. 从表的外键类型必须与主表的主键类型一致
		2. 添加数据时,应该先添加主表的数据
		3. 删除数据的时候 要先删除从表中的数据
*/

-- 添加一个新的部门
INSERT INTO department(dep_name,dep_location) VALUES('市场部','北京');

-- 添加一个属于市场部的员工
INSERT INTO employee(ename,age,dept_id) VALUES('老胡',24,3);

/*
	级联删除
		指的是在删除主表的数据的同时,可以删除与之相关的从表中的数据
	
	级联删除
		on delete cascade
*/
-- 重新创建添加级联操作
CREATE TABLE employee(
	eid INT PRIMARY KEY AUTO_INCREMENT,
	ename VARCHAR(20),
	age INT,
	dept_id INT,
	CONSTRAINT emp_dept_fk FOREIGN KEY(dept_id) REFERENCES department(id)
	-- 添加级联删除
	ON DELETE CASCADE
);

-- 添加数据
INSERT INTO employee (ename, age, dept_id) VALUES ('张百万', 20, 1); 
INSERT INTO employee (ename, age, dept_id) VALUES ('赵四', 21, 1); 
INSERT INTO employee (ename, age, dept_id) VALUES ('广坤', 20, 1); 
INSERT INTO employee (ename, age, dept_id) VALUES ('小斌', 20, 2); 
INSERT INTO employee (ename, age, dept_id) VALUES ('艳秋', 22, 2); 
INSERT INTO employee (ename, age, dept_id) VALUES ('大玲子', 18, 2); 

-- 删除部门编号为 2 的数据
DELETE FROM department WHERE id = 2;

/*
	表与表之间的三种关系
		一对多关系(1:n 常见): 班级和学生 部门和员工
		多对多关系(n:n 常见): 学生与课程 演员和角色
		一对一关系(1:1 了解): 身份证 和 人
*/

-- 一对多关系 省表与市表

-- 创建省表 主表 一的一方
CREATE TABLE province(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(20),
	description VARCHAR(20)
);

-- 创建市表 从表 中 外键字段指向 主表的主键
CREATE TABLE city(
	cid INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(20),
	description VARCHAR(20),
	
	-- 创建外键 添加外键约束
	pid INT,
	FOREIGN KEY(pid) REFERENCES province(id)
);


-- 多对多关系 演员与角色

-- 演员表
CREATE TABLE actor(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(20)
);

-- 角色表
CREATE TABLE role(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(20)
);

-- 创建中间表
CREATE TABLE actor_role(
	-- 中间表的主键
	id INT PRIMARY KEY AUTO_INCREMENT,
	
	-- aid 字段 指向 actor表的主键
	aid INT,
	
	-- rid 指向 role表的主键
	rid INT
);


-- 添加外键约束

-- aid字段添加外键约束
ALTER TABLE actor_role ADD FOREIGN KEY(aid) REFERENCES actor(id);

-- rid字段添加外键约束
ALTER TABLE actor_role ADD FOREIGN KEY(rid) REFERENCES role(id);




























