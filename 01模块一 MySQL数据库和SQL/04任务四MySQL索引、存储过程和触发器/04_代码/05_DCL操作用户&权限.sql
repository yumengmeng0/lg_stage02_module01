/*
	DCL 创建用户
	语法结构
		create user '用户名'@'主机名' identified by '密码';
*/

-- 创建 admin1 用户，只能在 localhost 这个服务器登录 mysql 服务器，密码为 123456
CREATE USER 'admin1'@'localhost' IDENTIFIED BY '123456';

-- 创建 admin2 用户可以在任何电脑上登录 mysql 服务器，密码为 123456
CREATE USER 'admin2'@'%'  IDENTIFIED BY '123456'; -- %表示在任意电脑都可以登录

/*
	用户的授权
	语法格式
		grant 权限1,权限2 ... on 数据库名.表 to '用户名'@'主机名'
*/
--  给 admin1 用户分配对 db4 数据库中 products 表的 操作权限：查询 
GRANT SELECT ON db4.`products` TO 'admin1'@'localhost';

-- 给 admin2 用户分配所有权限，对所有数据库的所有表
GRANT ALL ON *.* TO 'admin2'@'%';

-- 查询 商品表
SELECT * FROM products;

-- 插入商品数据
-- INSERT command denied to user 'admin1'@'localhost' for table 'products'
-- admin1用户只有查询权限
INSERT INTO products VALUES('p010','小鸟伏特加',3000,1,NULL);


/*
	查看用户权限
	语法格式
		show grants for '用户名'@'主机名';
*/

-- 查看root用户的权限
SHOW GRANTS FOR 'root'@'localhost';

-- 查看 admin1 用户的权限
SHOW GRANTS FOR 'admin1'@'localhost';

-- 删除用户
DROP USER 'admin1'@'localhost';

-- 查询用户
SELECT * FROM USER;



















