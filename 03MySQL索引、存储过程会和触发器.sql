/*
	索引：通过对数据表中的字段创建索引来提高查询速度
	
	常见的索引分类：
		1.主键索引（primary key）：
			主键是一个唯一性的索引，每个表中只能有一个主键
		2.唯一索引（unique）：
			索引列的所有数据只能出现一次，必须唯一
		3.普通索引（index）：
			最常见的索引，作用是提高对数据的访问速度
			
	表对应的索引被保存在一个索引文件中
*/

DROP DATABASE IF EXISTS db4;
CREATE DATABASE db4 CHARACTER SET utf8;

USE db4;

CREATE TABLE index_demo(
	did INT,
	dname VARCHAR(20),
	hobby VARCHAR(30)
);


/*
	主键索引
		1.创建时直接添加主键
		2.创建表之后使用DDL
*/

# 添加主键索引
ALTER TABLE index_demo ADD PRIMARY KEY(did);

/*
	创建唯一索引
		create unique index 索引名 on 表名(列名(长度));
*/

# 为hobby添加唯一索引
CREATE UNIQUE INDEX ind_hobby ON index_demo(hobby);

INSERT INTO index_demo  VALUES(1,'tom','篮球');
INSERT INTO index_demo  VALUES(2,'tom1','篮球');


/*
	创建普通索引
		1.create index 索引名 on 表名(列名[长度]);
		2.alter table 表名 add index 索引名(列名);
*/

ALTER TABLE index_demo ADD INDEX index_name(dname);

/*
	删除索引

		alter table 表名 drop 索引名
*/

/*
	总结：
		创建所有的原则：选择查询条件或排序、分组后面的字段创建索引
	优点：
		1.大大提高查询速度
		2.减少查询中分组和排序的时间
		3.通过创建唯一索引保证数据的唯一性
		
	缺点：
		1.创建和维护索引需要时间，数据量越大，时间越长
		2.表中的数据进行增删改炒作时，索引也需要进行维护，降低了维护的速度
		3.索引文件需要占磁盘空间
*/


/*
	视图：
		1.由查询结果形成的一张虚拟表
		2.建立在已有表的基础上，视图赖以建立的这些表称为基表
		3.向视图提供数据内容的语句为select语句，可以将视图理解为存储起来的select语句
		4.向用户提供基表数据的另一种表现形式
	
	视图的作用：
		1.权限控制
		2.简化复杂的多表查询
		
	语法格式：
		create view 视图名 [column_list] as select语句;
		
	
	视图和表的区别：
			1.视图是建立在表的基础之上
			2.不要对视图进行增删改操作，视图主要是用来简化查询
			3.删除视图，表不受影响，删除表，视图不再起作用
*/


/*
	存储过程：
		一种在数据库中存储的复杂程序，以便外部调用的数据库对象。
		存储过程是一堆sql语句的合并，中间加入了一些逻辑控制
		
	优点：
		1.调试完成就可以稳定运行（在业务稳定运行的情况）
		2.存储过程可以减少业务系统与数据库的交互
		
	缺点；
		1.业务变化快的项目中较少使用
		2.移植困难
		
*/


/*

*/

# 商品表
CREATE TABLE goods(
	gid INT,
	NAME VARCHAR(20),
	num INT -- 库存
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
	创建存储过程的方式1：
	语法格式：
		delimiter $$  				#声明语句介绍符号，自定义
		create procedure 存储过程名称()		#声明存储过程
		begin   				# 开始编写存储过程
							# 要执行的sql			
		end $$					#存储过结束
		
	调用存储过程：
		call 存储过程名称();

*/


DELIMITER $$
CREATE PROCEDURE goods_procdure()
BEGIN
	SELECT * FROM goods;
END $$

CALL 

/*
	创建存储过程的方式2：创建一个接收参数的存储过程
		语法格式：
		delimiter $$  				#声明语句介绍符号，自定义  (定界符，分隔符);
		create procedure 存储过程名称(in 参数名 参数类型)		#声明存储过程
		begin   				# 开始编写存储过程
							# 要执行的sql			
		end $$					#存储过结束

	
*/

# 创建一个接收商品id根据id删除数据

DELIMITER $$
CREATE PROCEDURE delete_good_by_id(IN id INT)
BEGIN
	DELETE FROM goods WHERE gid = id;
END $$


CALL delete_good_by_id(1);

/*
	创建存储过程的方式2：获取存储过程的返回值
		1.变量名的赋值
			set @变量 = 值
			
		2.out 输出参数
			out 变量 数据类型
*/

# 向订单中插入数据，返回1表示插入成功
DELIMITER $$
CREATE PROCEDURE add_good_by_id(IN o_oid INT,IN o_gid INT, IN o_price INT,OUT out_num INT)
BEGIN
	INSERT INTO orders VALUES (o_oid,o_gid,o_price);
	
	# 设置返回值
	SET @out_num = 1;
	# 返回
	SELECT @out_num;
END $$


CALL add_good_by_id(1,2,50,@out_num);


/*
	触发器（trigger）：
		是mysql提供给程序员和数据分析员来保证数据完整性的一种方法，它是与表事件相关的特殊存储过程，
		它执行过程不是由程序调用，也不是手工启动，而是由事件来触发，比如当对一个表进行操作（insert，delete、update）
		时就会激活它执行。
		
	触发器四要素：
		1.监视地点（table）
		2.监视事件（insert/update/delete）
		3.触发时间（before/after）
		4.触发事件（insert/update/delete）
		
	创建触发器：
		delimiter $ 				# 自定义结束符号
		create trigger trigger_name		# 触发器名
		before/after （insert/update/delete）	# 触发实际和监视事件
		on table_name				# 触发器所在的表
		for each row 				# 固定写法
		begin
		
		
		end $
*/


# 向商品中添加一条数据
INSERT INTO goods VALUES(1,'book',40);

INSERT INTO orders VALUES(1,1,25)


DELIMITER $
CREATE TRIGGER t1
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
	UPDATE goods SET num = num - 1 WHERE gid = 1; # 订单加1库存减1
END $


/*
	DCL数据控制语言
		mysql默认都是root用户，超级管理员，拥有全部权限。
		除了root用户以外，可以通过DCL语言定义一些权限较小的用户，分配不同的权限，来管理数据库。
	
	创建用户：
		create user '用户名'@'主机名' identitied by '密码';
*/

CREATE USER 'admin'@'localhost' IDENTIFIED BY '123456';

# % 表示在任意电脑都可以登录
CREATE USER 'admin1'@'%' IDENTIFIED BY '123456';


/*
	用户的授权
	语法格式：
		grant 权限... on 数据库名.表名 to '用户名'@'主机名';
*/

USE db4;
SELECT DATABASE();
SHOW TABLES

GRANT SELECT ON db4.`index_demo` TO 'admin1'@'localhost';

# 分配所有权限
GRANT ALL ON *.* TO 'admin1'@'%';


/*
	查看用户权限
		show grants for '用户名'@'主机名'
*/

SHOW GRANTS FOR 'admin1'@'localhost';

UPDATE index_demo SET dname = 'jack' WHERE did = 1;


/*
	删除用户
	drop user
*/

# 删除用户
DROP USER 'admin'@'localhost';

USE mysql;
# 查询用户
SELECT * FROM USER;


/*
	数据库备份
		语法：
		备份（只备份数据，没有备份数据库，还原时需要自己创建数据库）：
			mysqldump -u用户名 -p密码 数据库名 > 路径
		还原：
			source sql文件地址
	
*/
