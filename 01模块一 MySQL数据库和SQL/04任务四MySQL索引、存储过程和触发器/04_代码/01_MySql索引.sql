/*
	索引概念
		我们可以通过对数据表中的字段创建索引 来提高查询速度
	
	常见的索引的分类
		主键索引 (primary key) 主键是一个唯一性的索引 每个表中只能有一个主键
		唯一索引 (unique) 索引列的所有数据只能出现一次,必须是唯一
		普通索引 (index) 最常见的索引 作用就是提高对数据的访问速度
		
	表对应的索引被保存在一个索引文件中, 如果对数据进行增删改操作,那么mysql就需要对索引进行更新
	
*/

/*
	主键索引的创建
		1.创建表的时候 直接添加主键
		2.创建表之后 添加索引 使用 DDL
*/

-- 为demo01表添加 主键索引
ALTER TABLE demo01 ADD PRIMARY KEY (did);

/*
	唯一索引的创建
		create unique index 索引名 on 表名(列名(长度))
*/

-- 为demo01表的 hobby字段添加唯一索引
CREATE UNIQUE INDEX ind_hobby ON demo01(hobby);

-- 添加唯一索引的列,列的所有值都只能出现一次
INSERT INTO demo01 VALUES(1,'tom','篮球');

-- Duplicate entry '篮球' for key 'ind_hobby'
-- 唯一索引保证了数据的唯一性, 同时也提升了查询效率
INSERT INTO demo01 VALUES(2,'jack','篮球');


/*
	普通索引的创建
		1.create index 索引名 on 表名(列名[长度])
		2.ALTER TABLE 表名 ADD INDEX 索引名 (列名)
*/
-- 为 demo01表中的 dname字段添加普通索引
ALTER TABLE demo01 ADD INDEX ind_dname(dname);

/*
	删除索引
		ALTER  TABLE 表名  DROP INDEX 索引名;
*/
-- 删除dname字段上的索引
ALTER TABLE demo01 DROP INDEX ind_dname;


-- 导入测试索引.sql 文件

-- test_index 表中有 500万条数据
SELECT COUNT(*) FROM test_index;

-- 通过id查询一条数据
SELECT * FROM test_index WHERE id = 100001;

-- 通过 dname字段查询 耗时2秒左右
SELECT * FROM test_index WHERE dname = 'name5200';

-- 执行分组查询 dname没有添加索引 36秒
SELECT * FROM test_index GROUP BY dname;

-- dname字段添加索引
ALTER TABLE test_index ADD INDEX dname_indx(dname);

SELECT * FROM test_index GROUP BY dname;

/*
	索引的总结
		创建索引的原则
			优先选择为 经常出现在 查询条件或者排序 分组后面的字段 创建索引.
		
	索引的优点
		1.可以大大的提高查询速度
		2.减少查询中分组和排序的时间
		3.通过创建唯一索引保证数据的唯一性
		
	索引缺点
		1.创建和维护索引需要时间,数据量越大 时间越长.
		2.表中的数据进行增删改操作时,索引也需要进行维护,降低了维护的速度
		3.索引文件需要占据磁盘空间
*/









