/*
	触发器
		当我们执行一条sql语句的时候，这条sql语句的执行会自动去触发执行其他的sql语句。
	
	触发器创建的四个要素
		1. 监视地点（table） 
		2. 监视事件（insert/update/delete）  
		3. 触发时间（before/after）  
		4. 触发事件（insert/update/delete） 
	
	创建触发器
	语法结构
		delimiter $ -- 自定义结束符号
		create trigger  触发器名
		after/before(insert/update/delete) -- 触发的时机 和监视的事件
		on tableName -- 触发器所在表
		for each row -- 固定写法 表示行触发器
		begin
			-- 被触发的事件
		end $
*/
-- 向商品表中插入数据
INSERT INTO goods VALUES(4,'book',40);


-- 需求: 在下订单的时候，对应的商品的库存量要相应的减少，卖出商品之后减少库存量
/*
	监视的表 orders
	监视的事件 insert
	触发的时间 after
	触发的事件 update
*/
-- 1.修改结束符号
DELIMITER $
-- 2.创建触发器
CREATE TRIGGER t1
-- 3.设置触发的时间 以及监视的事件 监视的表
AFTER INSERT ON orders
-- 4.行触发器
FOR EACH ROW
-- 5.触发后要执行的操作
BEGIN
	-- 执行修改库存的操作 订单+1 库存-1
	UPDATE goods SET num = num - 1 WHERE gid = 4;
END $

-- 向orders表插入一个订单
INSERT INTO orders VALUES(1,4,25);








