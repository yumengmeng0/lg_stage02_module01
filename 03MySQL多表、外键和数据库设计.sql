/*
	外键：在从表中与主表的主键对应的字段。
	外键约束；让两张表之间产生对应的关系，保证主表引用的完整性
	主表和从表：
		主表：主键id所在的表
		从表：外键字段所在的表
		
	添加外键约束的语法格式
		1.创建表的时候添加外键
		create table 表名(
			字段...
			[constrait] [外键约束] foreign key(外键字段名) references 主表(主表字段)
		);
	
*/


DROP DATABASE IF EXISTS db3 ;
CREATE DATABASE db3 CHARACTER SET utf8;
USE db3;
SELECT DATABASE();
SELECT USER();


-- 创建部门表
-- 一方,主表
CREATE TABLE department(
	id INT PRIMARY KEY AUTO_INCREMENT,
	dep_name VARCHAR(30),
	dep_location VARCHAR(30)
);

-- 添加2个部门
INSERT INTO department VALUES(NULL, '研发部','广州'),(NULL, '销售部', '深圳');
SELECT * FROM department;

-- 创建员工表，添加外键
CREATE TABLE employee(
	eid INT PRIMARY KEY AUTO_INCREMENT,
	ename VARCHAR(20),
	age INT,
	dept_id INT,-- 外键约束字段，指向了主表的主键
	CONSTRAINT emp_dept_fk FOREIGN KEY(dept_id) REFERENCES department(id)
);

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
	删除外键约束
		alter table 从表 drop foreign key 外键约束名称;
*/

ALTER TABLE employee DROP FOREIGN KEY emp_dept_fk;

-- 创建完表之后添加外键，外键名自动添加employee_ibfk_1
ALTER TABLE employee ADD CONSTRAINT FOREIGN KEY(dept_id) REFERENCES department(id);


/*
	外键约束的注意事项
		1.外键的类型必须与主表的数据类型保持一致
		2.添加数据时，先添加主表的数据
		3.删除数据时，先删除从表中的数据（主表在从表没有引用的外键在主表中可以删除）
	
	
	级联删除：
		在删除主表数据时，可以删除与之关联的从表中的数据
	
*/


-- 创建表时添加级联删除
CREATE TABLE employee(
	eid INT PRIMARY KEY AUTO_INCREMENT,
	ename VARCHAR(20),
	age INT,
	dept_id INT,-- 外键约束字段，指向了主表的主键
	CONSTRAINT emp_dept_fk FOREIGN KEY(dept_id) REFERENCES department(id)
	ON DELETE CASCADE
);


/*
	表与表之间的三种关系：
		一对一：可以在任意一方建立外键，设置为唯一
		一对多：在多的一方建立外键，指向一的一方的主键
		多对多：多对多中创建表的原则，需要创建第三张表，中间表至少有两个字段，是两张表中的主键，作为中间表的外键
		
*/

/*
	省市表（一对多）
*/

-- 创建省份表
CREATE TABLE province(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(20),
	description VARCHAR(20)
);


-- 创建市表
CREATE TABLE city(
	cid INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(20),
	description VARCHAR(20),
	pid INT, # 创建外键，添加外键约束
	FOREIGN KEY(pid) REFERENCES province(id)
);


/*
	演员-角色表（多对多）
*/

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

-- 中间表
CREATE TABLE actor_role(
	id INT PRIMARY KEY AUTO_INCREMENT,
	aid INT, # 指向actor表的主键
	rid INT  # 指向role表的主键
); 


-- 添加外键约束
ALTER TABLE actor_role ADD FOREIGN KEY(aid) REFERENCES actor(id);
ALTER TABLE actor_role ADD FOREIGN KEY(rid) REFERENCES role(id);




/*
	多表查询
	
*/

DROP DATABASE IF EXISTS db3_2;
CREATE DATABASE db3_2 CHARACTER SET utf8;
USE db3_2;


# 分类表（一方 主表）
CREATE TABLE category(
	cid VARCHAR(32) PRIMARY KEY,
	cname VARCHAR(50)
);

# 商品表（多方 从表）
CREATE TABLE products(
	pid VARCHAR(32) PRIMARY KEY,
	pname VARCHAR(50),
	price INT,
	flag VARCHAR(2), #是否上架：1表示上架，0表示下架
	category_id VARCHAR(32),
	# 添加外键约束
	FOREIGN KEY (category_id) REFERENCES category(cid)
);


#分类数据
INSERT INTO category(cid,cname) VALUES('c001','家电');
INSERT INTO category(cid,cname) VALUES('c002','鞋服');
INSERT INTO category(cid,cname) VALUES('c003','化妆品');
INSERT INTO category(cid,cname) VALUES('c004','汽车');
#商品数据
INSERT INTO products(pid, pname,price,flag,category_id) VALUES('p001','小米电视机',5000,'1','c001');
INSERT INTO products(pid, pname,price,flag,category_id) VALUES('p002','格力空调',3000,'1','c001');
INSERT INTO products(pid, pname,price,flag,category_id) VALUES('p003','美的冰箱',4500,'1','c001');
INSERT INTO products (pid, pname,price,flag,category_id) VALUES('p004','篮球鞋',800,'1','c002');
INSERT INTO products (pid, pname,price,flag,category_id) VALUES('p005','运动裤',200,'1','c002');
INSERT INTO products (pid, pname,price,flag,category_id) VALUES('p006','T恤',300,'1','c002');
INSERT INTO products (pid, pname,price,flag,category_id) VALUES('p007','冲锋衣',2000,'1','c002');
INSERT INTO products (pid, pname,price,flag,category_id) VALUES('p008','神仙水',800,'1','c003');
INSERT INTO products (pid, pname,price,flag,category_id) VALUES('p009','大宝',200,'1','c003');

/*
	笛卡尔积
*/

# 交叉连接查询会产生笛卡尔积，基本不会使用
SELECT * FROM products,category;

/*
	1. 内连接查询：通过指定的条件，去匹配两张表中的内容，匹配不上的就不显示
		1.1 隐式内连接
			语法格式：select 字段名... from 左表,右表 where 连接条件;
				
		1.2 显示内连接
			语法格式；select 字段名... from 左表[inner] join 右表 on 连接条件;
	2.外连接查询：
		


*/


# 1.查询所有商品信息和对应分类信息
# 隐式内连接
SELECT * FROM products,category WHERE category_id = cid; 

# 显示内连接
SELECT * FROM products p INNER JOIN category c ON category_id = cid; 

# 2.查询商品名称个价格、商品分类信息

SELECT 
	p.`pname`,
	p.`price`,
	c.`cname`
FROM products p,category c WHERE p.`category_id` = c.cid; 

# 查询格力空调属于哪一分类下的商品
SELECT 
	p.`pname`,
	c.cname
FROM products p,category c WHERE p.`category_id` = c.cid AND p.`pid`='p002'


# 查询鞋服分类下，价格大于500的商品名称
/*
	查询之前要确定的事；
		1.查询几张表
		2. 查询的连接条件
		3.查询所用到的字段
		4.查询的条件

*/


SELECT 
	p.pname,
	p.price
FROM products p INNER JOIN category c ON p.category_id = c.cid
WHERE p.price > 500 AND c.cname = '鞋服'

/*
	外连接查询
		1.左外连接
			left [outer] jion
			select 字段名 from 左表 left [outer] join 右表 on 连接条件;
		特点：
			以左表为基准，匹配右表中是数据，如果能匹配得上就显示，匹配不上，
			左表中的数据正常显示，右表数据显示为null
		2.右外连接
			select 字段名 from 左表 right [outer] join 右表 on 连接条件;
*/

# 左外连接
SELECT * FROM category c LEFT JOIN products p ON c.`cid` = p.`category_id`;

# 查询每个分类下商品个数
SELECT 
	c.`cname`,
	COUNT(p.pid)
FROM category c LEFT JOIN products p ON c.`cid` = p.category_id
GROUP BY c.`cname`;


# 右外连接
SELECT * FROM products p RIGHT JOIN category c ON p.`category_id` = c.`cid`;

/*
	子查询：一条select语句的结果，作为另外一条select语句的一部分
		子查询必须要放在小括号中
	
	子查询分类：
		where型子查询：子查询的结果作为父查询的比较条件使用
		from型子查询：将子查询的结果作为一张编表使用
		exists型子查询：查询结果是单列多行的情况，可以将子查询的结果作为父查询的in函数中的条件使用
*/

-- 查询价格最高的商品信息
-- 1.查询最高的价格
SELECT MAX(price) FROM products;
-- 2.根据最高价格查出商品信息
SELECT * FROM products WHERE price = 5000;


-- 子查询
SELECT * FROM products WHERE price = (SELECT MAX(price) FROM products);

-- 子查询作为查询条件’
-- 查询化妆品分类下的商品名称、商品价格

-- 查询化妆品id
SELECT cid FROM category WHERE cname = '化妆品';

SELECT 
	p.pname,
	p.price
FROM products p WHERE category_id = (SELECT cid FROM category WHERE cname = '化妆品');

-- 查询商品中，价格大于500的商品信息，包括 商品名称 商品价格 商品所属分类名称
SELECT * FROM category;

SELECT	
	p.`pname`,
	p.`price`,
	c.cname
FROM products p
# 子查询作为一种表
INNER JOIN (SELECT * FROM category) c ON p.`category_id` = c.cid
WHERE p.price > 500;


/*
	子查询的结果是单列多行，作为父查询的in函数中的条件使用
	语法格式：
		select 字段名 from 表名 where 字段 in(子查询);
*/

-- 查询价格小于两千的商品，来自于哪些分类
-- 1.查询小于两千的商品分类id
SELECT DISTINCT category_id FROM products WHERE price < 2000;

SELECT cname FROM category WHERE cid IN(SELECT DISTINCT category_id FROM products WHERE price < 2000);


/*
	子查询总结：
		1.子查询如果是一个字段，那么就在where后面做条件
		2.子查询如果是多个字段，就当作一张表使用（要起别名）
*/


/*
	数据库三范式：
		第一范式（1NF）：原子性，做到列不可拆分
		第二范式（2NF）；一张表只能描述一件事，确保表中的每列都和主键相关
		第三范式（3NF）：消除传递依赖，如果表的信息能够被推导出来，就不应设计一个字段单独存放
		
	反三范式：通过增加冗余字段或重复数据来提高数据库的读性能
		
	冗余字段：同时属于多张表且完全等同于它在其本来所属表的意义表示
	
	总结；
		1.尽量遵循范式理论的约束，尽可能减少冗余字段
		2.合理加入冗余字段

*/
