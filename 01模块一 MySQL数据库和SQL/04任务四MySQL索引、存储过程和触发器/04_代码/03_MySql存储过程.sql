/*
	存储过程其实就是一堆 SQL 语句的合并。中间加入了一些逻辑控制。
	
	存储过程的优缺点
		优点
			1.调试完成就可以稳定运行 (在业务需求相对稳定情况)
			2.存储过程可以减少 业务系统与数据库的交互
		
		缺点
			1.互联网项目中 较少使用存储过程,因为 业务需求变化太快
			2.存储过程的移植十分困难.
			
*/
# 商品表
CREATE TABLE goods(
  gid INT,
  NAME VARCHAR(20),
  num INT  -- 库存
);

#订单表
CREATE TABLE orders(
  oid INT,
  gid INT,
  price INT -- 订单价格
);

# 向商品表中添加3条数据
INSERT INTO goods VALUES(1,'奶茶',20);
INSERT INTO goods VALUES(2,'绿茶',100);
INSERT INTO goods VALUES(3,'花茶',25);

/*
	创建存储过程方式1:
		
	语法格式
		delimiter $$ -- 声明语句的结束符号 自定义 ||
		create procedure 存储过程名称() -- 声明存储过程
		begin   -- 开始编写存储过程
		
			-- 要执行的SQL
			
		end $$ -- 存储过程结束
*/

-- 编写存储过程, 查询所有商品数据
DELIMITER $$
CREATE PROCEDURE goods_proc()
BEGIN 
	-- 查询商品数据
	SELECT * FROM goods;
END $$

-- 调用存储过程 call
CALL goods_proc;


/*
	存储过程创建方式2: 创建一个接收参数的存储过程
	
	语法格式
		create procedure 存储过程名(IN 参数名 参数类型)
*/

-- 创建存储过程 接收一个商品id, 根据id删除数据
DELIMITER $$
CREATE PROCEDURE goods_proc02(IN goods_id INT)
BEGIN 
	-- 根据id删除商品数据
	DELETE FROM goods WHERE gid = goods_id;
END $$

-- 调用存储过程 传递参数
CALL goods_proc02(1);

/*
	存储过程创建方式3 获取存储过程的返回值
	
	1.变量的赋值
		SET @变量名 = 值
	2.OUT 输出参数
		OUT 变量名 数据类型
*/

-- 向订单表 插入一条数据, 返回1,表示插入成功
DELIMITER $$
CREATE PROCEDURE orders_proc(IN o_oid INT,IN o_gid INT ,IN o_price INT,OUT out_num INT)
BEGIN 
	-- 执行插入操作
	INSERT INTO orders VALUES(o_oid,o_gid,o_price);
	-- 设置 out_num 值为1
	SET @out_num = 1;
	
	-- 返回 out_num
	SELECT @out_num;
END $$

-- 调用存储过程 获取返回值
CALL orders_proc(1,2,50,@out_num);



















