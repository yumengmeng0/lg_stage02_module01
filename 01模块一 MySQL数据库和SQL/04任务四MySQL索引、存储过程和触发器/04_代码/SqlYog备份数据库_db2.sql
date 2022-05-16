/*
SQLyog Ultimate v12.5.0 (64 bit)
MySQL - 5.7.28-log : Database - db2
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db2` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `db2`;

/*Table structure for table `account` */

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(10) DEFAULT NULL,
  `money` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `account` */

insert  into `account`(`id`,`NAME`,`money`) values 
(1,'tom',1500),
(2,'jack',1000),
(3,'lucy',1000);

/*Table structure for table `emp` */

DROP TABLE IF EXISTS `emp`;

CREATE TABLE `emp` (
  `eid` int(11) DEFAULT NULL,
  `ename` varchar(20) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `salary` double DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `dept_name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `emp` */

insert  into `emp`(`eid`,`ename`,`sex`,`salary`,`hire_date`,`dept_name`) values 
(1,'孙悟空','男',7200,'2013-02-04','教学部'),
(2,'猪八戒','男',3600,'2010-12-02','教学部'),
(3,'唐僧','男',9000,'2008-08-08','教学部'),
(4,'白骨精','女',5000,'2015-10-07','市场部'),
(5,'蜘蛛精','女',5000,'2011-03-14','市场部'),
(6,'玉兔精','女',200,'2000-03-14','市场部'),
(7,'林黛玉','女',10000,'2019-10-07','财务部'),
(8,'黄蓉','女',3500,'2011-09-14','财务部'),
(9,'吴承恩','男',20000,'2000-03-14',NULL),
(9,NULL,'女',NULL,NULL,'教学部');

/*Table structure for table `emp2` */

DROP TABLE IF EXISTS `emp2`;

CREATE TABLE `emp2` (
  `eid` int(11) NOT NULL AUTO_INCREMENT,
  `ename` varchar(20) NOT NULL,
  `sex` char(1) DEFAULT NULL,
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `emp2` */

insert  into `emp2`(`eid`,`ename`,`sex`) values 
(1,'张三','男'),
(2,'李四','女');

/*Table structure for table `emp3` */

DROP TABLE IF EXISTS `emp3`;

CREATE TABLE `emp3` (
  `eid` int(11) NOT NULL,
  `ename` varchar(20) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  PRIMARY KEY (`eid`),
  UNIQUE KEY `ename` (`ename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `emp3` */

insert  into `emp3`(`eid`,`ename`,`sex`) values 
(1,'张百万','女'),
(2,NULL,'女');

/*Table structure for table `emp4` */

DROP TABLE IF EXISTS `emp4`;

CREATE TABLE `emp4` (
  `eid` int(11) NOT NULL,
  `ename` varchar(20) DEFAULT NULL,
  `sex` char(1) DEFAULT '女',
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `emp4` */

insert  into `emp4`(`eid`,`ename`,`sex`) values 
(1,'杨幂','女'),
(2,'柳岩','女'),
(3,'蔡徐坤','男');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
