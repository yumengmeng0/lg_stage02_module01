
/*
	简单查询
		select 列名 from 表名;	
*/

-- 员工表
CREATE TABLE emp(
	eid INT,
	ename VARCHAR(20),
	sex CHAR(1),
	salary DOUBLE,
	hire_date DATE,
	dept_name VARCHAR(20)
);

#添加数据
INSERT INTO emp VALUES(1,'孙悟空','男',7200,'2013-02-04','教学部');
INSERT INTO emp VALUES(2,'猪八戒','男',3600,'2010-12-02','教学部');
INSERT INTO emp VALUES(3,'唐僧','男',9000,'2008-08-08','教学部');
INSERT INTO emp VALUES(4,'白骨精','女',5000,'2015-10-07','市场部');
INSERT INTO emp VALUES(5,'蜘蛛精','女',5000,'2011-03-14','市场部');
INSERT INTO emp VALUES(6,'玉兔精','女',200,'2000-03-14','市场部');
INSERT INTO emp VALUES(7,'林黛玉','女',10000,'2019-10-07','财务部');
INSERT INTO emp VALUES(8,'黄蓉','女',3500,'2011-09-14','财务部');
INSERT INTO emp VALUES(9,'吴承恩','男',20000,'2000-03-14',NULL);
INSERT INTO emp VALUES(10,'孙悟饭','男', 10,'2020-03-14',财务部);


-- 查询emp 中所有数据
SELECT * FROM emp;

SELECT eid,ename FROM emp;

SELECT 
	eid AS '编号',  # 别名 AS 可以省略
	ename AS '姓名',
	sex '性别'
FROM emp;


-- 查询有几个部门
SELECT dept_name FROM emp;

-- 去重：distinct
SELECT DISTINCT dept_name FROM emp;

SELECT ename, salary + 1000 FROM emp;

-- 查询操作并不会修改数据库中的数据


/*
	条件查询
		select 列名 from 表名 where 条件表达式;
		
		比较运算符：
			> < <= >= = <> !=
			between ... and ... 
			in(集合)
			like'%张%'
			is null
			
		逻辑运算符：&&（and） ||（or） not 
			
*/

/*
	排序
	order by子句
	语法结构：
	select 字段名 from 表名 [where 字段名 = 值] order by 字段名[asc/desc] 
	
	
*/

-- 单列排序，按照某一个字段排序
USE db2;
SELECT * FROM emp ORDER BY salary;

SELECT * FROM emp ORDER BY salary DESC;

-- 组合排序
SELECT * FROM emp ORDER BY salary DESC, eid DESC;



/*
	聚合函数：将一列数据作为一个整体，进行纵向计算
	常用聚合函数
		count(字段)
		sum(字段)
		max(字段)
		min(字段)
		avg(字段)
		
	格式：
	select 聚合函数名(字段) from 表名 [where 条件]
	
*/

#1.查询员工总数
SELECT * FROM emp;
SELECT COUNT(eid) '员工总数' FROM emp;

/*
	分组查询：group by子句
	select 分组字段/聚合函数 from 表名 group by 分组字段
	
	
*/
SELECT * FROM emp GROUP BY sex;
SELECT sex FROM emp GROUP BY sex; # 按性别分组，只返回分组的第一条数据

# 通过性别字段进行分组，求平均薪资
SELECT sex, AVG(salary) FROM emp GROUP BY sex;

# 查询平均薪资大于6000的部门
-- 1.首先要分组求平均薪资
-- 2.求出平均薪资大于6000的部门
-- 分组之后进行条件过滤：having


SELECT 
	dept_name,
	AVG(salary)
FROM emp
WHERE dept_name IS NOT NULL GROUP BY dept_name
HAVING AVG(salary)>6000;

/*
	limit 限制查询数据条数
	语法格式：
		select 字段 from 表 limit offset,length;
	参数说明：
		offset：起始行数，默认0
		length：返回数据条数
*/

#查询前5条数据
SELECT * FROM emp LIMIT 5,5;