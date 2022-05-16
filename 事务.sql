/*
	事务是由一个或者多条sql语句组成的一个整体，要么全部成功，要么全部失败
*/

-- 创建账户表

CREATE TABLE account(
	id INT PRIMARY KEY AUTO_INCREMENT, # 主键
	NAME VARCHAR(20), # 姓名
	money DOUBLE
);

-- 添加两个账户
INSERT INTO account(NAME, money) VALUES ('tom',1000), ('jerry',1000);


UPDATE account SET money = money + 500 WHERE NAME = 'tom';

UPDATE account SET money = money - 500 WHERE NAME = 'jerry';

/*
	mysql事务
		1. 手动提交事务
			1.1 开启事务：start transaction或者 begin
			1.2 提交事务：commit
			1.3 回滚事务：rollback

		2. 自动提交事物
			mysql默认提交方式，每执行一条sql都是一个单独的事务
		
*/

/*
	事务的四大特性（ACID）：
		1. 原子性：每个事务都是一个整体，不可以再拆分。
		2. 一致性： 事务在执行前数据库的状态与执行后数据库的状态保持一致。
		3. 隔离性：事务与事务之间不应该相互影响，执行保持隔离状态。
		4. 持久性：一旦事务执行成功，对数据库的修改是持久的。
*/


/*
	mysql的隔离级别
		各个事务之间的隔离，相互独立，但如果多个事务对数据库中的同一批数据进行并发访问的时候，就会引发一些问题。
		可以通过设置不同的隔离级别来解决
	
	并发访问的问题
		脏读：一个事务读到了另一个事务没有提交的数据
		不可重复读：一个事务中两次读取的数据不一致（事务在读取时被其他事务修改过数据）
		幻读：一个事务中，一次查询的结果，无法支撑后续的业务操作
		
	设置隔离级别
		read uncommitted：读未提交
			可以防止的问题：无
		read committed：读已提交 （Oracle）
			可以防止：脏读
		repeatable read: 可重复读（mysql）
			可以防止：脏读，不可重复读
			读取的是第一次查询到的数据
		serializable：串行化（前面有事务没有提交不能修改数据）
			可以防止：脏读，不可重复读，幻读
	
	隔离级别越高，安全性越高，效率越低

*/


/*
	隔离级别的相关命令
		1. 查看隔离级别
			select @@tx_isolation;
		2. 设置隔离级别
			set global transaction isolation level 级别名称;


*/

SELECT @@tx_isolation; # REPEATABLE-READ

