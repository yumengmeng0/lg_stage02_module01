/*
	什么是视图
		视图是由查询结果形成的一张虚拟的表.
	
	视图的作用
		如果某个查询的结果出现的十分频繁,并且查询语法比较复杂.
		那么这个时候,就可以根据这条查询语句构建一张视图 方便查询
		
	视图的语法
		create view 视图名[字段列表] as select 查询语句;
		
		view 表示视图
		字段列表 一般跟后面的查询语句 相同
		as select 查询语句 表示给视图提供数据的 查询语句
*/
-- 创建视图
-- 1.查询所有商品和商品对应分类的信息
SELECT * FROM products p LEFT JOIN category c ON p.`category_id` = c.`cid`;

-- 2.根据上面的查询语句 构建一张视图
CREATE VIEW products_category_view AS
SELECT * FROM products p LEFT JOIN category c ON p.`category_id` = c.`cid`;

-- 操作视图 就相当于操作一张 只读表
SELECT * FROM products_category_view;


-- 使用视图进行查询操作

-- 查询各个分类下的商品平均价格
/*
	1.查询哪些表 分类表 商品表
	2.查询条件是什么  分组操作
	3.要查询的字段	平均价格,分类名
	4.多表的连接条件 category_id = cid
*/

-- 使用多表方式查询
SELECT 
	c.`cname`,
	AVG(p.`price`)
FROM products p LEFT JOIN category c ON p.`category_id` = c.`cid`
GROUP BY c.`cname`;


-- 通过视图查询
SELECT 
	pc.`cname`,
	AVG(pc.`price`)
FROM products_category_view pc GROUP BY pc.`cname`;


-- 查询鞋服分类下最贵的商品的全部信息
-- 多表查询
-- 1.查询鞋服分类中 最高的商品价格
SELECT 
	MAX(p.`price`)
FROM products p LEFT JOIN category c ON p.`category_id` = c.`cid` 
WHERE c.`cname` = '鞋服';

-- 2.进行子查询 将上面的查询结果作为条件
SELECT 
	*
FROM products p LEFT JOIN category c 
ON p.`category_id` = c.`cid`
WHERE c.`cname` = '鞋服' AND p.`price` = 
(
	SELECT 
		MAX(p.`price`)
	FROM products p LEFT JOIN category c ON p.`category_id` = c.`cid` 
	WHERE c.`cname` = '鞋服'
);

-- 通过视图查询
SELECT 
	*
FROM products_category_view pc 
WHERE pc.`cname` = '鞋服' AND pc.`price` = 
(
-- 子查询 求出鞋服分类下的最高价格
SELECT MAX(pc.`price`) FROM products_category_view pc 
WHERE pc.`cname` = '鞋服' ); 


/*
	视图与表的区别
		1.视图是建立在表的基础之上
		2.通过视图 不要进行增删改操作,视图主要就是用来简化查询
		3.删除视图 表不受影响,删除表 视图就不在起作用了.
*/
















