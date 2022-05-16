-- 创建账户表
CREATE TABLE account(
	-- 主键
	id INT PRIMARY KEY AUTO_INCREMENT,
	-- 姓名
	NAME VARCHAR(10),
	-- 余额
	money DOUBLE
);

-- 添加两个用户
INSERT INTO account (NAME, money) VALUES ('tom', 1000), ('jack', 1000);

-- tom账户 -500元
UPDATE account SET money = money - 500 WHERE NAME = 'tom';

出错了

-- jack账户 + 500元
UPDATE account SET money = money + 500 WHERE NAME = 'jack';

/*
	MySql事务操作
		手动提交事务
			1.开启事务 start transaction; 或者 begin;
			2.提交事务 commit;
			3.回滚事务 rollback;
			
		自动提交事务
			MySql默认的提交方式 自动提交事务
			每执行一条DML语句 都是一个单独的事务
			
*/
-- 手动提交事务演示

-- 成功案例
USE db2;

start transaction;  -- 开启事务

update account set money = money - 500 where name = 'tom'

update account set money = money + 500 where name = 'jack';

commit;	-- 提交事务

-- 失败案例 会进行回滚
start transaction; -- 开启事务

INSERT INTO account VALUES(NULL,'张百万',3000);
INSERT INTO account VALUES(NULL,'有财',3500);


-- 直接关闭窗口 模拟系统崩溃 数据没有发生改变

-- 如果事务中 SQL 语句没有问题，commit 提交事务，会对数据库数据的数据进行改变。 如果事务中 SQL 语句有问题，rollback 回滚事务，会回退到开启事务时的状态。 

-- 自动提交事务 MySQL 默认每一条 DML(增删改)语句都是一个单独的事务

--  登录mysql，查看autocommit状态。
SHOW VARIABLES LIKE 'autocommit';

-- 把 autocommit 改成 off;
SET @@autocommit=off;

-- 执行修改操作

-- 选择数据库
use db2;

-- 修改数据
update account set money = money - 500 where name = 'jack';

-- 手动提交
commit;

/*
	事务的四大特性
		原子性
			每个事务都是一个整体,不可以再拆分,事务中的所有SQL
			要么都执行成功 要么都执行失败
			
		一致性
			事务在执行之前 数据库的状态,与事务执行之后的状态要保持一致
		
		隔离性
			事务与事务之间不应该相互影响,执行时要保证隔离状态
		
		持久性
			一旦事务执行成功,对数据的修改是持久的.		
		
*/

/*
	MySql的隔离级别
			各个事务之间是隔离,相互独立.但是如果多个事务对数据库中的同一批数据
		进行并发访问的时候,就会引发一些问题,可以通过设置不同的隔离级别来解决
		对应的问题
	
	并发访问的问题
		脏读: 一个事务读取到了另一个事务没有提交的数据.
		不可重复读:	一个事务中 两次读取的数据不一致.
		幻读: 一个事务中,一次查询的结果,无法支撑后续的业务操作.
	
	设置隔离级别
		read uncommitted: 读未提交
			可以防止哪些问题: 无
			
		read committed: 读已提交 (Oracle默认 隔离级别)
			可以防止: 脏读
		
		repeatable read : 可重复读	(MySql默认的隔离级别)
			可以防止: 脏读 ,不可重复读
			
		serializable : 串行化
			可以防止: 脏读 ,不可重复读 ,幻读
			
	注意: 隔离级别 从小到大 安全性是越来越高的,但是效率是越来越低的,
	根据不同的情况选择对应的隔离级别
	
*/


/*
	查看隔离级别
	select @@tx_isolation;
	
	设置隔离级别
	set global transaction isolation level 级别名称;
	read uncommitted 读未提交
	read committed   读已提交
	repeatable read  可重复读
	serializable     串行化

*/
-- 查看隔离级别	MySql默认隔离级别  repeatable read
select @@tx_isolation;

-- 设置隔离级别为 读已提交
set global transaction isolation level read committed ;
















