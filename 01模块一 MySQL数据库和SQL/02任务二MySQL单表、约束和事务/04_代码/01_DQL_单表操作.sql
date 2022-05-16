/*
	排序 
	使用 order by子句
	语法结构: 	select 字段名 from 表名 [where 字段名 = 值] order by 字段名称 [ASC/DESC]
		ASC 升序排序 (默认升序)
		DESC 降序排序
*/

-- 单列排序 按照某一个字段进行排序
-- 使用salary 字段 对emp表进行排序
SELECT * FROM emp ORDER BY salary; -- 默认升序
SELECT * FROM emp ORDER BY salary DESC; -- 降序排序


-- 组合排序 同时对多个字段进行排序
-- 在薪资的排序基础上,再去使用 id字段进行排序
SELECT * FROM emp ORDER BY salary DESC ,eid DESC;

-- 组合排序的特点: 如果第一个字段 值相同,就按照第二个字段进行排序.


/*
	聚合函数
		作用:将一列数据作为一个整体,进行纵向的计算的
	
	常用的聚合函数
		count(字段) 统计记录数
		sum(字段) 求和操作
		max(字段) 求最大值
		min(字段) 求最小值
		avg(字段) 求平均值
	
	语法格式
		select 聚合函数(字段名) from 表名 [where 条件]
*/

#1 查询员工的总数
SELECT COUNT(*) FROM emp; 
SELECT COUNT(1) FROM emp;
SELECT COUNT(eid) FROM emp;

-- count函数 在统计的时候回忽略空值
-- 注意 不要使用带空值的列 进行 count
SELECT COUNT(dept_name) FROM emp;

#2 查看员工总薪水、最高薪水、最小薪水、薪水的平均值
SELECT 
	SUM(salary) AS '总薪水',
	MAX(salary) '最高薪水',
	MIN(salary) '最小薪水',
	AVG(salary) '平均薪水'
FROM emp

#3 查询薪水大于4000员工的个数
SELECT COUNT(*) FROM emp WHERE salary > 4000;

#4 查询部门为'教学部'的所有员工的个数
SELECT COUNT(*) FROM emp WHERE dept_name = '教学部';

#5 查询部门为'市场部'所有员工的平均薪水
SELECT AVG(salary) FROM emp WHERE dept_name = '市场部';


/*
	分组查询 使用 group by 子句
	
	语法格式: select 分组字段/聚合函数 from 表名 group by 分组字段
*/

SELECT * FROM emp GROUP BY sex;

# 通过性别字段 进行分组,求各组的平均薪资
SELECT sex, AVG(salary) FROM emp GROUP BY sex;


#1.查询所有部门信息 
SELECT dept_name AS '部门名称' FROM emp GROUP BY dept_name;

#2.查询每个部门的平均薪资
SELECT dept_name,AVG(salary) FROM emp GROUP BY dept_name;

#3.查询每个部门的平均薪资, 部门名称不能为null
SELECT 
	dept_name AS '部门名称',
	AVG(salary) AS '部门平均薪资'
FROM emp 
WHERE dept_name IS NOT NULL 
GROUP BY dept_name;

# 查询平均薪资大于6000的部门.
-- 1. 首先要分组求平均薪资
-- 2. 求出 平均薪资大于 6000的部门

-- 在分组之后 进行条件过滤 使用:  having 判断条件

SELECT 
	dept_name,
	AVG(salary)
FROM emp 
WHERE dept_name IS NOT NULL GROUP BY dept_name 
HAVING	AVG(salary) > 6000;

/*
	where 与 having的区别
		where 
			1.在分组前进行过滤
			2.where后面不能跟 聚合函数
		having
			1.是在分组后进行条件过滤
			2.having 后面可以写 聚合函数

*/

/*
	limit 通过limit 去指定要查询的数据的条数 行数
	
	语法格式
		select 字段 from 表名 limit offset, length;
	参数说明:
		offset: 起始行数 默认从0 开始计数
		length: 返回的行数 (要查询几条数据)
*/

# 查询emp表中的前 5条数据
SELECT * FROM emp LIMIT 0,5;
SELECT * FROM emp LIMIT 5;

# 查询emp表中 从第4条开始,查询6条
SELECT * FROM emp LIMIT 3 , 6;

-- limit 分页操作, 每页显示3条
SELECT * FROM emp LIMIT 0,3; -- 第一页
SELECT * FROM emp LIMIT 3,3; -- 第二页
SELECT * FROM emp LIMIT 6,3; -- 第三页 3-1=2 2*3=6

-- 分页公式 起始行数 = (当前页码 - 1) * 每页显示条数





























