/*
	多表查询的语法
		select 字列表段 from 表名列表;

*/

CREATE DATABASE db3_2 CHARACTER SET utf8;

#分类表 (一方 主表)
CREATE TABLE category (
  cid VARCHAR(32) PRIMARY KEY ,
  cname VARCHAR(50)
);

#商品表 (多方 从表)
CREATE TABLE products(
  pid VARCHAR(32) PRIMARY KEY ,
  pname VARCHAR(50),
  price INT,
  flag VARCHAR(2),		#是否上架标记为：1表示上架、0表示下架
  category_id VARCHAR(32),
  -- 添加外键约束
  FOREIGN KEY (category_id) REFERENCES category (cid)
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

-- 多表查询 交叉连接查询 的查询结果会产生 笛卡尔积 是不能够使用的.
SELECT * FROM products ,category;

/*
	1.内连接查询
	2.外连接查询
*/

/*
	内连接查询
		特点 通过指定的条件 去匹配俩张表中的内容, 匹配不上的就不显示
		
		隐式内连接
			语法格式: select 字段名... from 左表,右表 where 连接条件
			
		显式内连接
			语法格式: select 字段名... from 左表 [inner] join 右表 on 连接条件
			inner 可以省略
	
*/

-- 1.查询所有商品信息和对应的分类信息
-- 隐式内连接
SELECT * FROM products , category WHERE category_id = cid;

-- 2.查询商品表的商品名称 和 价格,以及商品的分类信息
-- 多表查询中 可以使用给表起别名的方式 简化查询
SELECT  
	p.`pname`,
	p.`price`,
	c.`cname`
FROM products p,category c WHERE p.`category_id` = c.`cid`;

--  查询 格力空调是属于哪一分类下的商品 
SELECT 
	p.`pname`,
	c.`cname`
FROM products p, category c WHERE p.`category_id` = c.`cid` AND p.`pid` = 'p002';


-- 1.查询所有商品信息和对应的分类信息
-- 显式内连接
SELECT 
* 
FROM products p 
INNER JOIN category c ON p.`category_id` = c.`cid`;

-- 2.查询鞋服分类下,价格大于500的商品名称和价格
/*
	查询之前要确定几件事情
		1.查询几张表 products &  category
		2.表的连接条件 p.`category_id` = c.`cid`; 从表.外键 = 主表.主键
		3.查询所用到的字段  商品名称  价格
		4.查询的条件 分类 = 鞋服,  价格 > 500
*/

SELECT 
	p.`pname`,
	p.`price`
FROM products p 
INNER JOIN category c ON p.`category_id` = c.`cid`
WHERE p.`price` > 500 AND c.`cname` = '鞋服';

/*
	外连接查询
		左外连接
			语法格式 关键字 left [outer] join 
				select 字段名 from 左表 left join 右表 on 连接条件
			左外连接的特点
				以左表为基准 匹配右表中的数据 如果能匹配上就显示
				如果匹配不上, 左表中的数据正常显示,右表数据显示为null
		
		右外连接
			语法格式 关键字 right [outer]  join
				select 字段名 from 左表 right join 右表 on 条件
			右外连接的特点
				以右表为基准 匹配左表中的数据 如果能够匹配上 就显示
				如果匹配不到 右表中的数据就正常显示 左表显示null
		
*/

-- 左外连接查询
SELECT 
* 
FROM category c 
LEFT JOIN products p ON c.`cid` = p.`category_id`;

--  查询每个分类下的商品个数
/*
	1.查询的表
	2.查询的条件 分组 统计
	3.查询的字段 分类 分类下商品个数信息
	4.表的连接条件
*/

SELECT 
	c.`cname`,
	COUNT(p.`pid`)
FROM
-- 表连接
category c  LEFT JOIN products p ON c.`cid` = p.`category_id`
-- 分组
GROUP BY c.`cname`;


-- 右外连接查询
SELECT * FROM products p RIGHT JOIN category c ON p.`category_id` = c.`cid`;





























