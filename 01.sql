-- 查询所有的数据库列表
SHOW DATABASES;

/*
	对数据库的操作分类：
		CRUD
		C Create 创建
		R Retrieve 查询
		U Update 更新
		D Delete 删除
	
*/

/*
	创建数据库
	DEFAULT CHARACTER SET latin1
*/

DROP DATABASE db*;
DROP DATABASE db1;

/*
	指定字符集
*/
CREATE DATABASE db1_1 CHARACTER SET utf8;

/*
	查看数据
	
*/

# 切换数据库
USE db1;
USE db1_1;

# 查询当前数据库
SELECT DATABASE(); 

-- 修改数据库的字符集

ALTER DATABASE db1 CHARACTER SET utf8;

-- 查询当前数据库的基本信息
SHOW CREATE DATABASE db1;

-- 删除数据库

DROP DATABASE db1; # 永久删除


/*
	创建表
		create table 表名(
			字段名称 字段类型(长度),
			字段名称1 字段类型(长度) 最后一个字段不加,
		);
		
	
	常见数据类型
	int
	float
	varchar		可变字符串
	date		yyyy-MM-dd
	datetime	yyyy-MM-dd HH:mm:ss
	char  		字符串
	
	varchar和char区别：
	
		
*/


/*
	
*/

USE db1;

-- 创建商品分类表
CREATE TABLE category(
	cid INT,
	cname VARCHAR(20)
);


-- 创建测试表
CREATE TABLE test1(
	tid INT,
	tdate DATE
);

-- 快速创建一个表结构相同的表（复制表结构）
CREATE TABLE test2 LIKE test1;

-- 查看表结构
DESCRIBE test1;

-- 查看表 show
-- 查看当前数据库中所有数据表名
SHOW TABLES;

-- 查看创建表的sql
SHOW CREATE TABLE category; 
/*
CREATE TABLE `category` (
  `cid` int(11) DEFAULT NULL,
  `cname` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8
*/

SHOW ENGINES;


SHOW DATABASES;




/*
	表的删除
		drop table 表名; #永久删除
		drop table if exists 表名;
*/

DROP TABLE IF EXISTS test1;


/*
	修改表名
	修改表字符集
	修改表中一列（数据类型、名称、长度）
	向表中添加一列
	删除表的一列

*/

-- 修改表名： rename table 旧表名 to 新表名
RENAME TABLE category TO category1;

-- 修改表的字符集
ALTER TABLE category1 CHARACTER SET gbk;

-- 向表中添加字段: alter table 表名 add 字段名称 字段类型(长度)
ALTER TABLE category1 ADD cdesc VARCHAR(20);


-- 修改表中列的类型或长度 modify
-- alter table 表名 modify 字段名称 字段类型
ALTER TABLE category1 MODIFY cdesc VARCHAR(50);
ALTER TABLE category1 MODIFY cdesc CHAR(20);

-- 修改列的名称 change 必须有修改后的类型
-- alter table 表名 change 旧列名 新列名 类型(长度) VARCHAR(30)  
ALTER TABLE category1 CHANGE cdesc description VARCHAR(30);

-- 删除列：alter table 表名 drop 列名
ALTER TABLE category1 DROP cname;


/*
	
*/
