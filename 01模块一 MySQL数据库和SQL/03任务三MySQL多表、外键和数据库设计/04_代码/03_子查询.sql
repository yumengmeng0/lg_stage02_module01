/*
	子查询 subQuery
		一条select语句的结果,作为另外一条select语句的一部分.
	
	子查询的特点
		子查询必须要放在 小括号中
		子查询作为父查询的条件使用(更多的时候)
*/

-- 查询价格最高的商品信息
-- 1.查询出最高的价格
SELECT MAX(price) FROM products ; -- 5000

-- 2.根据最高价格 查出商品信息
SELECT * FROM products WHERE price = 5000;

-- 使用一条SQL完成 子查询方式
SELECT * FROM products WHERE price = (SELECT MAX(price) FROM products );

/*
	子查询分类
		where型子查询: 将子查询的结果 作为父查询的 比较条件使用.
		from型子查询: 将子查询的查询结果作为一张表使用
		exists 型子查询: 查询结果是单列多行的情况,可以将子查询的结果作为父查询的 in函数中的条件使用
*/

-- 子查询作为查询条件

-- 1. 查询化妆品分类下的 商品名称 商品价格
-- 查询出化妆品分类的 id
SELECT cid FROM category WHERE cname = '化妆品'; -- c003

-- 2.根据化妆品id 查询对应商品信息
SELECT 
	p.`pname`,
	p.`price`
FROM products p
WHERE p.`category_id` = (SELECT cid FROM category WHERE cname = '化妆品');

-- 查询小于平均价格的商品信息
-- 1.求出平均价格
SELECT AVG(price) FROM products; -- 1866

-- 2.获取小于平均价格的商品信息
SELECT 
* 
FROM products
WHERE price < (SELECT AVG(price) FROM products);


-- from型子查询方式 

-- 查询商品中,价格大于500的商品信息,包括 商品名称 商品价格 商品所属分类名称
SELECT * FROM category;

SELECT 
	p.`pname`,
	p.`price`,
	c.cname
FROM products p 
-- 注意 子查询的结果作为一张表时,要起一个别名 否则无法访问表中的字段
INNER JOIN (SELECT * FROM category) c ON p.`category_id` = c.cid 
WHERE p.`price` > 500;

/*
	子查询的结果是单列多行, 作为父查询的 in 函数中的条件使用
	语法格式
		select 字段名 from 表名 where 字段 in(子查询);
*/
-- 查询价格小于两千的商品,来自于哪些分类(名称)

-- 1.查询小于两千的商品的 分类id
SELECT DISTINCT category_id FROM products WHERE price < 2000;

-- 2.根据分类的id 查询 分类的信息
SELECT * FROM category 
WHERE cid IN 
(SELECT DISTINCT category_id FROM products WHERE price < 2000);


-- 查询家电类 与 鞋服类下面的全部商品信息
-- 1.首先要获取 家电类和鞋服类 分类id
SELECT cid FROM category WHERE cname IN('家电','鞋服');

-- 2.根据 分类id 查找商品信息
SELECT 
	* 
FROM products WHERE category_id IN
(SELECT cid FROM category WHERE cname IN('家电','鞋服'));

-- 子查询的总结
-- 1.子查询如果是一个字段(单列) ,那么就在where后面做条件
-- 2.如果是多个字段(多列) 就当做一张表使用 (要起别名)





