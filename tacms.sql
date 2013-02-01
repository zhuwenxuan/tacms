/*
SQLyog Ultimate v9.0 Beta1
MySQL - 5.1.41-community-log : Database - ta_cms
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `tacms_access` */

CREATE TABLE `tacms_access` (
  `role_id` smallint(6) unsigned NOT NULL,
  `node_id` smallint(6) unsigned NOT NULL,
  `level` tinyint(1) NOT NULL,
  `pid` smallint(6) NOT NULL,
  `module` varchar(50) DEFAULT NULL,
  KEY `groupId` (`role_id`),
  KEY `nodeId` (`node_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `tacms_access` */

insert  into `tacms_access`(`role_id`,`node_id`,`level`,`pid`,`module`) values (3,1,1,0,NULL),(1,96,0,30,NULL),(1,95,1,0,NULL),(3,50,3,40,NULL),(3,7,2,1,NULL),(3,39,3,30,NULL),(1,90,1,0,NULL),(1,87,1,0,NULL),(4,1,1,0,NULL),(4,2,2,1,NULL),(4,3,2,1,NULL),(4,4,2,1,NULL),(4,5,2,1,NULL),(4,6,2,1,NULL),(4,7,2,1,NULL),(4,11,2,1,NULL),(5,25,1,0,NULL),(5,51,2,25,NULL),(1,30,1,0,NULL),(1,2,2,90,NULL),(1,6,2,90,NULL),(1,7,2,90,NULL),(1,69,2,87,NULL),(1,80,2,30,NULL),(3,69,2,1,NULL),(3,30,2,1,NULL),(3,40,2,1,NULL),(1,31,3,30,NULL),(1,32,3,30,NULL),(1,33,3,30,NULL),(1,34,3,30,NULL),(1,35,3,30,NULL),(1,36,3,30,NULL),(1,37,3,30,NULL),(1,39,3,30,NULL),(7,90,1,0,NULL),(7,30,2,1,NULL),(7,40,2,1,NULL),(7,69,2,1,NULL),(7,50,3,40,NULL),(7,39,3,30,NULL),(7,49,3,30,NULL),(7,87,1,0,NULL),(1,49,3,30,NULL),(1,97,0,6,NULL),(9,116,0,109,NULL),(9,115,0,109,NULL),(9,114,0,109,NULL),(9,99,0,0,NULL),(9,100,0,0,NULL),(9,101,0,0,NULL),(9,103,0,99,NULL),(9,102,0,99,NULL),(9,104,0,100,NULL),(9,105,0,101,NULL),(9,106,0,101,NULL),(9,107,0,101,NULL),(9,108,0,101,NULL),(9,109,0,0,NULL),(9,110,0,109,NULL),(9,111,0,109,NULL),(9,112,0,109,NULL),(9,113,0,109,NULL);

/*Table structure for table `tacms_category` */

CREATE TABLE `tacms_category` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '所属站点id',
  `type` tinyint(1) unsigned DEFAULT '0' COMMENT '栏目类型，0：普通栏目，1：单网页栏目',
  `modelid` smallint(6) unsigned DEFAULT '0',
  `pid` smallint(6) unsigned DEFAULT '0' COMMENT '父节点id',
  `name` varchar(30) DEFAULT NULL COMMENT ' 栏目名称',
  `sitelistlayoutid` int(32) DEFAULT NULL COMMENT '关联列表模板id',
  `sitecontentlayoutid` int(32) DEFAULT NULL COMMENT '关联内容模板id',
  `description` mediumtext COMMENT '描述',
  `url` varchar(100) DEFAULT NULL COMMENT '栏目url',
  `hits` int(10) unsigned DEFAULT '0' COMMENT '点击数',
  `sort` smallint(6) NOT NULL DEFAULT '0' COMMENT '排序字段',
  `ismenu` tinyint(1) unsigned DEFAULT '1' COMMENT '是否为餐单栏目，0：否，1：是',
  `sethtml` tinyint(1) unsigned DEFAULT '0' COMMENT '是否生成html页面，0：否，1：是',
  `status` char(1) NOT NULL DEFAULT '1',
  `createtime` int(11) DEFAULT NULL,
  `updatetime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `module` (`pid`,`sort`,`id`),
  KEY `siteid` (`site_id`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `tacms_category` */

insert  into `tacms_category`(`id`,`site_id`,`type`,`modelid`,`pid`,`name`,`sitelistlayoutid`,`sitecontentlayoutid`,`description`,`url`,`hits`,`sort`,`ismenu`,`sethtml`,`status`,`createtime`,`updatetime`) values (65,1,0,5,0,'5',NULL,NULL,'','',0,22,0,1,'1',NULL,NULL),(1,1,0,5,0,'出租',NULL,NULL,NULL,NULL,0,5,1,0,'1',NULL,NULL),(2,1,0,5,0,'出售',NULL,NULL,NULL,NULL,0,3,1,1,'1',NULL,NULL),(66,1,0,5,2,'123',NULL,NULL,'',NULL,0,123,1,0,'1',NULL,NULL),(67,1,0,1,0,'ac',1,1,'','',0,0,0,1,'1',1350027734,1350027740);

/*Table structure for table `tacms_diction` */

CREATE TABLE `tacms_diction` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL,
  `theme` varchar(32) NOT NULL,
  `path` varchar(32) NOT NULL,
  `filename` varchar(32) NOT NULL,
  PRIMARY KEY (`id`,`theme`,`path`,`filename`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Data for the table `tacms_diction` */

/*Table structure for table `tacms_download` */

CREATE TABLE `tacms_download` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `typeid` smallint(5) unsigned NOT NULL,
  `title` char(80) NOT NULL DEFAULT '',
  `style` char(24) NOT NULL DEFAULT '',
  `thumb` varchar(100) NOT NULL DEFAULT '',
  `keywords` char(40) NOT NULL DEFAULT '',
  `description` char(255) NOT NULL DEFAULT '',
  `posids` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `url` char(100) NOT NULL,
  `listorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `sysadd` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `islink` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `username` char(20) NOT NULL,
  `inputtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  `systems` varchar(100) NOT NULL DEFAULT 'Win2000/WinXP/Win2003',
  `copytype` varchar(15) NOT NULL DEFAULT '',
  `language` varchar(10) NOT NULL DEFAULT '',
  `classtype` varchar(20) NOT NULL DEFAULT '',
  `version` varchar(20) NOT NULL DEFAULT '',
  `filesize` varchar(10) NOT NULL DEFAULT 'Unkown',
  `stars` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `status` (`status`,`listorder`,`id`),
  KEY `listorder` (`catid`,`status`,`listorder`,`id`),
  KEY `catid` (`catid`,`status`,`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `tacms_download` */

insert  into `tacms_download`(`id`,`catid`,`typeid`,`title`,`style`,`thumb`,`keywords`,`description`,`posids`,`url`,`listorder`,`status`,`sysadd`,`islink`,`username`,`inputtime`,`updatetime`,`systems`,`copytype`,`language`,`classtype`,`version`,`filesize`,`stars`) values (19,1,1,'000011111','1','1','1','1',0,'1',0,1,0,0,'1',0,0,'Win2000/WinXP/Win2003','','','','','Unkown',''),(20,64,0,'title','','','你是   啊啊啊','<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;法撒旦发生</p>',0,'',0,1,0,0,'',0,0,'Win2000/WinXP/Win2003','','','','','Unkown',''),(21,64,0,'title','','','22222啊啊啊啊啊','<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;发生大发发生&nbsp;&nbsp;&nbsp;<br /></p>',0,'',0,1,0,0,'',0,0,'Win2000/WinXP/Win2003','','','','','Unkown',''),(22,64,0,'title  法撒旦发生','','','你是   啊啊啊','<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;发生大发三十三四十岁生生世世事实上生生死死</p>',0,'',0,1,0,0,'',0,0,'Win2000/WinXP/Win2003','','','','','Unkown',''),(23,64,0,'title  1法撒旦发生','','','你是   啊啊啊','<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;啛啛喳喳<br /></p>',0,'',0,1,0,0,'',0,0,'Win2000/WinXP/Win2003','','','','','Unkown',''),(24,64,0,'title  5555法撒旦发生','','','你是   啊啊啊','<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;发生大发生法生</p>',0,'',0,1,0,0,'',0,0,'Win2000/WinXP/Win2003','','','','','Unkown','');

/*Table structure for table `tacms_form` */

CREATE TABLE `tacms_form` (
  `id` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_time` int(11) unsigned NOT NULL,
  `update_time` int(11) unsigned NOT NULL,
  `status` tinyint(1) unsigned NOT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `tacms_form` */

/*Table structure for table `tacms_group` */

CREATE TABLE `tacms_group` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `create_time` int(11) unsigned NOT NULL,
  `pid` int(32) NOT NULL DEFAULT '0',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0',
  `show` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `site_id` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `tacms_group` */

insert  into `tacms_group`(`id`,`name`,`create_time`,`pid`,`update_time`,`status`,`sort`,`show`,`site_id`) values (18,'二手房网站',1345201562,0,0,1,1,1,2),(19,'上帝之组',1345258567,0,0,1,0,0,1),(20,'经理',1345265182,18,0,1,0,0,2),(21,'经理',1345270923,20,0,1,0,0,2),(22,'33',1345366853,18,0,1,33,0,2),(23,'3',1349921036,0,0,1,3,0,1),(24,'1-111',1349930662,23,0,1,111,0,1);

/*Table structure for table `tacms_group_user` */

CREATE TABLE `tacms_group_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` smallint(6) unsigned NOT NULL,
  `user_id` smallint(6) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

/*Data for the table `tacms_group_user` */

insert  into `tacms_group_user`(`id`,`group_id`,`user_id`) values (1,19,1),(2,18,4),(3,2,3),(4,7,2);

/*Table structure for table `tacms_hits` */

CREATE TABLE `tacms_hits` (
  `hitsid` char(30) NOT NULL,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `yesterdayviews` int(10) unsigned NOT NULL DEFAULT '0',
  `dayviews` int(10) unsigned NOT NULL DEFAULT '0',
  `weekviews` int(10) unsigned NOT NULL DEFAULT '0',
  `monthviews` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`hitsid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

/*Data for the table `tacms_hits` */

/*Table structure for table `tacms_home` */

CREATE TABLE `tacms_home` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(80) NOT NULL DEFAULT '' COMMENT '新闻标题',
  `thumb` varchar(1000) NOT NULL DEFAULT '' COMMENT '缩略图',
  `keywords` char(40) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` mediumtext NOT NULL COMMENT '描述',
  `updatetime` int(11) DEFAULT NULL COMMENT '修改时间',
  `createtime` int(11) NOT NULL COMMENT '创建时间',
  `price` int(11) NOT NULL DEFAULT '0' COMMENT '房源价格',
  `square` float NOT NULL DEFAULT '0' COMMENT '房屋平方',
  `homeregionid` int(11) NOT NULL COMMENT '房源区域',
  `homeconfigid` varchar(500) DEFAULT NULL COMMENT '配备',
  `hometypeid` int(11) NOT NULL COMMENT '类型',
  `high` int(3) NOT NULL DEFAULT '0' COMMENT '总层数',
  `myhigh` int(3) NOT NULL DEFAULT '0' COMMENT '第几层',
  `homesize` int(3) NOT NULL DEFAULT '0' COMMENT '室',
  `parlour` int(3) NOT NULL DEFAULT '0' COMMENT '厅',
  `toilet` int(3) NOT NULL DEFAULT '0' COMMENT '卫生间',
  `map` varchar(200) NOT NULL COMMENT '百度地图位置',
  `village` mediumtext NOT NULL COMMENT '小区简介',
  `userid` int(11) NOT NULL COMMENT '关联信息发布人员',
  `detailimages` mediumtext COMMENT '房屋图片',
  `face` varchar(50) DEFAULT NULL COMMENT '房屋朝向',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否被逻辑删除-1：删除 1:未删除',
  `publish` tinyint(1) NOT NULL DEFAULT '0' COMMENT '审核状态：-1未通过0未审核1审核通过',
  `fitment` tinyint(1) DEFAULT NULL COMMENT '装修：1普通装修，2精装修',
  `address` varchar(100) NOT NULL COMMENT '地址',
  PRIMARY KEY (`id`),
  KEY `status` (`id`),
  KEY `listorder` (`id`),
  KEY `catid` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `tacms_home` */

insert  into `tacms_home`(`id`,`title`,`thumb`,`keywords`,`description`,`updatetime`,`createtime`,`price`,`square`,`homeregionid`,`homeconfigid`,`hometypeid`,`high`,`myhigh`,`homesize`,`parlour`,`toilet`,`map`,`village`,`userid`,`detailimages`,`face`,`status`,`publish`,`fitment`,`address`) values (1,'tt','','r','<p>r</p>',1346902828,1346902828,800,7,5,'1,2,3,4',1,1,0,1,2,0,'','',0,NULL,NULL,1,0,NULL,''),(2,'发生大发','','发生大发','发大水发大水',1346902828,1346902828,0,0,5,'1,2,3,4',1,1,0,1,2,0,'3',' ',1,NULL,NULL,1,0,NULL,' '),(3,'3','','3','<p>3</p>',1346902823,1346902828,900,0,1,'1,4,',3,0,0,1,2,0,'dss','啛啛喳喳 ',1,NULL,'发生大',1,0,2,'fsdfds'),(4,'1','','1','<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1</p>',1346902828,1346902828,0,1,7,'1,2,3,4',1,1,1,1,1,1,'1','        1',0,NULL,'1',1,0,NULL,''),(5,'北苑双井世纪星城','5056ca3722365.jpgue_separate_ue/Tpl/Upload/50596a5ad9566.jpgue_separate_ue/Tpl/Uploads/505990695d8b2','通州-通州','<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;e</p>',1347375895,1346902828,0,3,1,'3,',1,3,3,3,3,3,'海淀区百度大厦','        ',0,NULL,'3',1,0,1,'33'),(6,'afaf','','a','<p>a</p>',1349961879,1349931297,0,0,1,'4,',1,0,0,0,0,0,'','',0,NULL,'',1,0,1,''),(7,'a','','f','',NULL,1349962033,0,3,0,'4',2,3,3,0,0,0,'','1',0,NULL,'a',1,0,1,'2'),(8,'','','','',NULL,1350012523,0,0,0,NULL,0,0,0,0,0,0,'','',0,NULL,'',-1,0,1,''),(9,'','','','',NULL,1350012600,0,0,0,NULL,0,0,0,0,0,0,'','',0,NULL,'',-1,0,1,''),(10,'1','','11','',NULL,1350020513,0,1,10,NULL,3,1,1,1,1,1,'1','1',0,NULL,'1',1,0,1,'1'),(11,'1','','1','1',NULL,1350021917,0,1,7,NULL,3,1,1,1,1,1,'1','1',0,NULL,'1',1,0,2,'1'),(12,'2','','2','2',NULL,1350022001,0,2,8,'2',2,2,2,2,2,2,'2','2',0,NULL,'2',1,0,1,'2'),(13,'a','','a','a',1350025489,1350023832,0,1,10,'1,2,3,',3,1,1,2,1,1,'1','a',0,NULL,'a',1,0,1,'a'),(14,'22','','2','2',NULL,1350026774,0,2,9,'',3,2,2,2,2,2,'2','2',0,NULL,'2',1,0,1,'2');

/*Table structure for table `tacms_home_config` */

CREATE TABLE `tacms_home_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `createtime` int(11) DEFAULT NULL,
  `updatetime` int(11) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '-1:删除，1未删除',
  `remark` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `tacms_home_config` */

insert  into `tacms_home_config`(`id`,`name`,`createtime`,`updatetime`,`status`,`remark`) values (1,'电冰箱',NULL,NULL,1,'1'),(2,'洗衣机',NULL,NULL,1,'2'),(3,'彩电',NULL,NULL,1,'3'),(4,'微波炉',NULL,NULL,1,'4');

/*Table structure for table `tacms_home_region` */

CREATE TABLE `tacms_home_region` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(50) DEFAULT NULL COMMENT '区域名称',
  `createtime` int(11) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(11) DEFAULT NULL COMMENT '更改时间',
  `status` int(11) DEFAULT '1' COMMENT '删除状态：1.未删除，-1.已经删除',
  `pid` int(11) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

/*Data for the table `tacms_home_region` */

insert  into `tacms_home_region`(`id`,`name`,`createtime`,`updatetime`,`status`,`pid`,`remark`) values (1,'西城区',1,1,1,0,NULL),(2,'海淀区',1,1,1,0,NULL),(5,'朝阳区',NULL,NULL,1,0,'f'),(6,'S',NULL,NULL,-1,1,'D'),(7,'ff',1346057440,1346057599,1,5,'af'),(8,'eee',1346772167,NULL,1,2,'ee'),(9,'fdddddddddddddddddddd',1349961545,1349961673,1,8,NULL),(10,'12',1350009946,1350009976,1,1,'1');

/*Table structure for table `tacms_home_type` */

CREATE TABLE `tacms_home_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `createtime` int(11) DEFAULT NULL,
  `updatetime` int(11) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '-1:已删除，1:未删除',
  `remark` varchar(200) DEFAULT NULL,
  `layout_id` smallint(8) NOT NULL DEFAULT '18',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

/*Data for the table `tacms_home_type` */

insert  into `tacms_home_type`(`id`,`name`,`createtime`,`updatetime`,`status`,`remark`,`layout_id`) values (1,'出售房源',NULL,NULL,-1,NULL,18),(2,'租房',NULL,NULL,1,NULL,18),(3,'日租房',NULL,NULL,1,NULL,18),(7,'s',1345994874,NULL,1,'s',18),(8,'1',1346903078,1350009669,1,'aa1',18),(9,'1-1',1350008900,NULL,-1,'1',18),(10,'1',1350026826,NULL,1,'',18),(11,'2',1350026866,NULL,1,'2',18),(12,'2',1350026871,NULL,1,'2',18),(13,'3',1350026875,NULL,1,'3',18),(14,'2',1350026879,NULL,1,'2',18),(15,'d',1350026884,NULL,1,'',18),(16,'dr',1350026888,NULL,1,'',18),(17,'rrrrrrrrrrrr',1350026892,NULL,1,'',18),(18,'ccccccccccc',1350026897,NULL,1,'',18),(19,'rrrrrrrrrr',1350026901,NULL,1,'',18),(20,'      gg',1350026909,NULL,1,'',18),(21,'fffffff',1350026920,NULL,1,'ffffffffffffffff',18),(22,'ssssssssssssssss',1350026924,NULL,1,'',18),(23,' v',1350026928,NULL,1,'',18),(24,'rs',1350026932,NULL,1,'',18),(25,' vvcvxd',1350026936,NULL,1,'',18),(26,'a3a',1350027006,NULL,1,'a',18);

/*Table structure for table `tacms_layout` */

CREATE TABLE `tacms_layout` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '布局id',
  `type` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '布局类型，如：index，list，content',
  `path` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '模板路径',
  `themeid` smallint(6) NOT NULL,
  `filename` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `thumb` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '缩略图路径',
  `description` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '模板描述，',
  `pid` smallint(6) NOT NULL DEFAULT '0',
  `sort` smallint(6) NOT NULL DEFAULT '0',
  `name` varchar(32) CHARACTER SET utf8 NOT NULL DEFAULT '布局',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Data for the table `tacms_layout` */

insert  into `tacms_layout`(`id`,`type`,`path`,`themeid`,`filename`,`thumb`,`description`,`pid`,`sort`,`name`,`status`) values (1,'Index','',1,'index_1','list_1.png','',0,0,'1',1),(15,'List','',1,'list_1','1','1',0,0,'布局',1),(16,'homeList','',1,'home_1','1','1',0,0,'布局',1);

/*Table structure for table `tacms_member` */

CREATE TABLE `tacms_member` (
  `id` smallint(8) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `update_time` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `tacms_member` */

/*Table structure for table `tacms_model` */

CREATE TABLE `tacms_model` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `name` char(30) NOT NULL,
  `description` char(100) NOT NULL,
  `tablename` char(20) NOT NULL,
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `default_style` char(30) NOT NULL,
  `category_template` char(30) NOT NULL,
  `list_template` char(30) NOT NULL,
  `show_template` char(30) NOT NULL,
  `sort` tinyint(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`siteid`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

/*Data for the table `tacms_model` */

insert  into `tacms_model`(`id`,`siteid`,`name`,`description`,`tablename`,`addtime`,`disabled`,`default_style`,`category_template`,`list_template`,`show_template`,`sort`) values (1,1,'文章模型','','news',0,0,'default','category','list','show',0),(2,1,'下载模型','','download',0,0,'default','category_download','list_download','show_download',0),(3,1,'图片模型','','picture',0,0,'default','category_picture','list_picture','show_picture',0),(4,1,'单页类型','单页类型','single_page',0,0,'','','','',0),(5,1,'房源类型','租房网','home',0,0,'','category','list','show',0);

/*Table structure for table `tacms_model_field` */

CREATE TABLE `tacms_model_field` (
  `fieldid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `modelid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `field` varchar(20) NOT NULL,
  `name` varchar(30) NOT NULL,
  `tips` text NOT NULL,
  `css` varchar(30) NOT NULL,
  `minlength` int(10) unsigned NOT NULL DEFAULT '0',
  `maxlength` int(10) unsigned NOT NULL DEFAULT '0',
  `pattern` varchar(255) NOT NULL,
  `errortips` varchar(255) NOT NULL,
  `formtype` varchar(20) NOT NULL,
  `setting` mediumtext NOT NULL,
  `formattribute` varchar(255) NOT NULL,
  `unsetgroupids` varchar(255) NOT NULL,
  `unsetroleids` varchar(255) NOT NULL,
  `iscore` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `issystem` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isunique` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isbase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `issearch` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isadd` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isfulltext` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isposition` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `listorder` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isomnipotent` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`fieldid`),
  KEY `modelid` (`modelid`,`disabled`),
  KEY `field` (`field`,`modelid`)
) ENGINE=MyISAM AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `tacms_model_field` */

insert  into `tacms_model_field`(`fieldid`,`modelid`,`siteid`,`field`,`name`,`tips`,`css`,`minlength`,`maxlength`,`pattern`,`errortips`,`formtype`,`setting`,`formattribute`,`unsetgroupids`,`unsetroleids`,`iscore`,`issystem`,`isunique`,`isbase`,`issearch`,`isadd`,`isfulltext`,`isposition`,`listorder`,`disabled`,`isomnipotent`) values (1,1,1,'catid','栏目','','',1,6,'/^[0-9]{1,6}$/','请选择栏目','catid','array (\n  \'defaultvalue\' => \'\',\n)','','-99','-99',0,1,0,1,1,1,0,0,1,0,0),(2,1,1,'typeid','类别','','',0,0,'','','typeid','array (\n  \'minnumber\' => \'\',\n  \'defaultvalue\' => \'\',\n)','','','',0,1,0,1,1,1,0,0,2,0,0),(3,1,1,'title','标题','','inputtitle',1,80,'','请输入标题','title','','','','',0,1,0,1,1,1,1,1,4,0,0),(4,1,1,'thumb','缩略图','','',0,100,'','','image','array (\n  \'size\' => \'50\',\n  \'defaultvalue\' => \'\',\n  \'show_type\' => \'1\',\n  \'upload_maxsize\' => \'1024\',\n  \'upload_allowext\' => \'jpg|jpeg|gif|png|bmp\',\n  \'watermark\' => \'0\',\n  \'isselectimage\' => \'1\',\n  \'images_width\' => \'\',\n  \'images_height\' => \'\',\n)','','','',0,1,0,0,0,1,0,1,14,0,0),(5,1,1,'keywords','关键词','多关键词之间用空格或者“,”隔开','',0,40,'','','keyword','array (\r\n  \'size\' => \'100\',\r\n  \'defaultvalue\' => \'\',\r\n)','','-99','-99',0,1,0,1,1,1,1,0,7,0,0),(6,1,1,'description','摘要','','',0,255,'','','textarea','array (\r\n  \'width\' => \'98\',\r\n  \'height\' => \'46\',\r\n  \'defaultvalue\' => \'\',\r\n  \'enablehtml\' => \'0\',\r\n)','','','',0,1,0,1,0,1,1,1,10,0,0),(7,1,1,'updatetime','更新时间','','',0,0,'','','datetime','array (\r\n  \'dateformat\' => \'int\',\r\n  \'format\' => \'Y-m-d H:i:s\',\r\n  \'defaulttype\' => \'1\',\r\n  \'defaultvalue\' => \'\',\r\n)','','','',1,1,0,1,0,0,0,0,12,0,0),(8,1,1,'content','内容','<div class=\"content_attr\"><label><input name=\"add_introduce\" type=\"checkbox\"  value=\"1\" checked>是否截取内容</label><input type=\"text\" name=\"introcude_length\" value=\"200\" size=\"3\">字符至内容摘要\r\n<label><input type=\'checkbox\' name=\'auto_thumb\' value=\"1\" checked>是否获取内容第</label><input type=\"text\" name=\"auto_thumb_no\" value=\"1\" size=\"2\" class=\"\">张图片作为标题图片\r\n</div>','',1,999999,'','内容不能为空','editor','array (\n  \'toolbar\' => \'full\',\n  \'defaultvalue\' => \'\',\n  \'enablekeylink\' => \'1\',\n  \'replacenum\' => \'2\',\n  \'link_mode\' => \'0\',\n  \'enablesaveimage\' => \'1\',\n)','','','',0,0,0,1,0,1,1,0,13,0,0),(9,1,1,'voteid','添加投票','','',0,0,'','','omnipotent','array (\n  \'formtext\' => \'<input type=\\\'text\\\' name=\\\'info[voteid]\\\' id=\\\'voteid\\\' value=\\\'{FIELD_VALUE}\\\' size=\\\'3\\\'> \r\n<input type=\\\'button\\\' value=\"选择已有投票\" onclick=\"omnipotent(\\\'selectid\\\',\\\'?m=vote&c=vote&a=public_get_votelist&from_api=1\\\',\\\'选择已有投票\\\')\" class=\"button\">\r\n<input type=\\\'button\\\' value=\"新增投票\" onclick=\"omnipotent(\\\'addvote\\\',\\\'?m=vote&c=vote&a=add&from_api=1\\\',\\\'添加投票\\\',0)\" class=\"button\">\',\n  \'fieldtype\' => \'mediumint\',\n  \'minnumber\' => \'1\',\n)','','','',0,0,0,1,0,0,1,0,21,0,0),(10,1,1,'pages','分页方式','','',0,0,'','','pages','','','-99','-99',0,0,0,1,0,0,0,0,16,0,0),(11,1,1,'inputtime','发布时间','','',0,0,'','','datetime','array (\n  \'fieldtype\' => \'int\',\n  \'format\' => \'Y-m-d H:i:s\',\n  \'defaulttype\' => \'0\',\n)','','','',0,1,0,0,0,0,0,1,17,0,0),(12,1,1,'posids','推荐位','','',0,0,'','','posid','array (\n  \'cols\' => \'4\',\n  \'width\' => \'125\',\n)','','','',0,1,0,1,0,0,0,0,18,0,0),(13,1,1,'url','URL','','',0,100,'','','text','','','','',1,1,0,1,0,0,0,0,50,0,0),(14,1,1,'listorder','排序','','',0,6,'','','number','','','','',1,1,0,1,0,0,0,0,51,0,0),(15,1,1,'status','状态','','',0,2,'','','box','','','','',1,1,0,1,0,0,0,0,55,0,0),(16,1,1,'template','内容页模板','','',0,30,'','','template','array (\n  \'size\' => \'\',\n  \'defaultvalue\' => \'\',\n)','','-99','-99',0,0,0,0,0,0,0,0,53,0,0),(17,1,1,'groupids_view','阅读权限','','',0,0,'','','groupid','array (\n  \'groupids\' => \'\',\n)','','','',0,0,0,1,0,0,0,0,19,0,0),(18,1,1,'readpoint','阅读收费','','',0,5,'','','readpoint','array (\n  \'minnumber\' => \'1\',\n  \'maxnumber\' => \'99999\',\n  \'decimaldigits\' => \'0\',\n  \'defaultvalue\' => \'\',\n)','','-99','-99',0,0,0,0,0,0,0,0,55,0,0),(19,1,1,'relation','相关文章','','',0,0,'','','omnipotent','array (\n  \'formtext\' => \'<input type=\\\'hidden\\\' name=\\\'info[relation]\\\' id=\\\'relation\\\' value=\\\'{FIELD_VALUE}\\\' style=\\\'50\\\' >\r\n<ul class=\"list-dot\" id=\"relation_text\"></ul>\r\n<div>\r\n<input type=\\\'button\\\' value=\"添加相关\" onclick=\"omnipotent(\\\'selectid\\\',\\\'?m=content&c=content&a=public_relationlist&modelid={MODELID}\\\',\\\'添加相关文章\\\',1)\" class=\"button\" style=\"width:66px;\">\r\n<span class=\"edit_content\">\r\n<input type=\\\'button\\\' value=\"显示已有\" onclick=\"show_relation({MODELID},{ID})\" class=\"button\" style=\"width:66px;\">\r\n</span>\r\n</div>\',\n  \'fieldtype\' => \'varchar\',\n  \'minnumber\' => \'1\',\n)','','2,6,4,5,1,17,18,7','',0,0,0,0,0,0,1,0,15,0,0),(20,1,1,'allow_comment','允许评论','','',0,0,'','','box','array (\n  \'options\' => \'允许评论|1\r\n不允许评论|0\',\n  \'boxtype\' => \'radio\',\n  \'fieldtype\' => \'tinyint\',\n  \'minnumber\' => \'1\',\n  \'width\' => \'88\',\n  \'size\' => \'1\',\n  \'defaultvalue\' => \'1\',\n  \'outputtype\' => \'1\',\n  \'filtertype\' => \'0\',\n)','','','',0,0,0,0,0,0,0,0,54,0,0),(21,1,1,'copyfrom','来源','','',0,100,'','','copyfrom','array (\n  \'defaultvalue\' => \'\',\n)','','','',0,0,0,1,0,1,0,0,8,0,0),(80,1,1,'username','用户名','','',0,20,'','','text','','','','',1,1,0,1,0,0,0,0,98,0,0),(22,2,1,'catid','栏目','','',1,6,'/^[0-9]{1,6}$/','请选择栏目','catid','array (\n  \'defaultvalue\' => \'\',\n)','','-99','-99',0,1,0,1,1,1,0,0,1,0,0),(23,2,1,'typeid','类别','','',0,0,'','','typeid','array (\n  \'minnumber\' => \'\',\n  \'defaultvalue\' => \'\',\n)','','','',0,1,0,1,1,1,0,0,2,1,0),(24,2,1,'title','标题','','inputtitle',1,80,'','请输入标题','title','','','','',0,1,0,1,1,1,1,1,4,0,0),(25,2,1,'keywords','关键词','多关键词之间用空格或者“,”隔开','',0,40,'','','keyword','array (\r\n  \'size\' => \'100\',\r\n  \'defaultvalue\' => \'\',\r\n)','','-99','-99',0,1,0,1,1,1,1,0,7,0,0),(26,2,1,'description','摘要','','',0,255,'','','textarea','array (\r\n  \'width\' => \'98\',\r\n  \'height\' => \'46\',\r\n  \'defaultvalue\' => \'\',\r\n  \'enablehtml\' => \'0\',\r\n)','','','',0,1,0,1,0,1,1,1,10,0,0),(27,2,1,'updatetime','更新时间','','',0,0,'','','datetime','array (\r\n  \'dateformat\' => \'int\',\r\n  \'format\' => \'Y-m-d H:i:s\',\r\n  \'defaulttype\' => \'1\',\r\n  \'defaultvalue\' => \'\',\r\n)','','','',1,1,0,1,0,0,0,0,12,0,0),(28,2,1,'content','内容','<div class=\"content_attr\"><label><input name=\"add_introduce\" type=\"checkbox\"  value=\"1\" checked>是否截取内容</label><input type=\"text\" name=\"introcude_length\" value=\"200\" size=\"3\">字符至内容摘要\r\n<label><input type=\'checkbox\' name=\'auto_thumb\' value=\"1\" checked>是否获取内容第</label><input type=\"text\" name=\"auto_thumb_no\" value=\"1\" size=\"2\" class=\"\">张图片作为标题图片\r\n</div>','',1,999999,'','内容不能为空','editor','array (\n  \'toolbar\' => \'full\',\n  \'defaultvalue\' => \'\',\n  \'enablekeylink\' => \'1\',\n  \'replacenum\' => \'2\',\n  \'link_mode\' => \'0\',\n  \'enablesaveimage\' => \'1\',\n  \'height\' => \'\',\n  \'disabled_page\' => \'1\',\n)','','','',0,0,0,1,0,1,1,0,13,0,0),(29,2,1,'thumb','缩略图','','',0,100,'','','image','array (\n  \'size\' => \'50\',\n  \'defaultvalue\' => \'\',\n  \'show_type\' => \'1\',\n  \'upload_maxsize\' => \'1024\',\n  \'upload_allowext\' => \'jpg|jpeg|gif|png|bmp\',\n  \'watermark\' => \'0\',\n  \'isselectimage\' => \'1\',\n  \'images_width\' => \'\',\n  \'images_height\' => \'\',\n)','','','',0,1,0,0,0,1,0,1,14,0,0),(30,2,1,'relation','相关文章','','',0,0,'','','omnipotent','array (\n  \'formtext\' => \'<input type=\\\'hidden\\\' name=\\\'info[relation]\\\' id=\\\'relation\\\' value=\\\'{FIELD_VALUE}\\\' style=\\\'50\\\' >\r\n<ul class=\"list-dot\" id=\"relation_text\"></ul>\r\n<div>\r\n<input type=\\\'button\\\' value=\"添加相关\" onclick=\"omnipotent(\\\'selectid\\\',\\\'?m=content&c=content&a=public_relationlist&modelid={MODELID}\\\',\\\'添加相关文章\\\',1)\" class=\"button\" style=\"width:66px;\">\r\n<span class=\"edit_content\">\r\n<input type=\\\'button\\\' value=\"显示已有\" onclick=\"show_relation({MODELID},{ID})\" class=\"button\" style=\"width:66px;\">\r\n</span>\r\n</div>\',\n  \'fieldtype\' => \'varchar\',\n  \'minnumber\' => \'1\',\n)','','2,6,4,5,1,17,18,7','',0,0,0,0,0,0,1,0,15,0,0),(31,2,1,'pages','分页方式','','',0,0,'','','pages','','','-99','-99',0,0,0,1,0,0,0,0,16,1,0),(32,2,1,'inputtime','发布时间','','',0,0,'','','datetime','array (\n  \'fieldtype\' => \'int\',\n  \'format\' => \'Y-m-d H:i:s\',\n  \'defaulttype\' => \'0\',\n)','','','',0,1,0,0,0,0,0,1,17,0,0),(33,2,1,'posids','推荐位','','',0,0,'','','posid','array (\n  \'cols\' => \'4\',\n  \'width\' => \'125\',\n)','','','',0,1,0,1,0,0,0,0,18,0,0),(34,2,1,'groupids_view','阅读权限','','',0,0,'','','groupid','array (\n  \'groupids\' => \'\',\n)','','','',0,0,0,1,0,0,0,0,19,0,0),(35,2,1,'url','URL','','',0,100,'','','text','','','','',1,1,0,1,0,0,0,0,50,0,0),(36,2,1,'listorder','排序','','',0,6,'','','number','','','','',1,1,0,1,0,0,0,0,51,0,0),(37,2,1,'template','内容页模板','','',0,30,'','','template','array (\n  \'size\' => \'\',\n  \'defaultvalue\' => \'\',\n)','','-99','-99',0,0,0,0,0,0,0,0,53,0,0),(38,2,1,'allow_comment','允许评论','','',0,0,'','','box','array (\n  \'options\' => \'允许评论|1\r\n不允许评论|0\',\n  \'boxtype\' => \'radio\',\n  \'fieldtype\' => \'tinyint\',\n  \'minnumber\' => \'1\',\n  \'width\' => \'88\',\n  \'size\' => \'1\',\n  \'defaultvalue\' => \'1\',\n  \'outputtype\' => \'1\',\n  \'filtertype\' => \'0\',\n)','','','',0,0,0,0,0,0,0,0,54,0,0),(39,2,1,'status','状态','','',0,2,'','','box','','','','',1,1,0,1,0,0,0,0,55,0,0),(40,2,1,'readpoint','阅读收费','','',0,5,'','','readpoint','array (\n  \'minnumber\' => \'1\',\n  \'maxnumber\' => \'99999\',\n  \'decimaldigits\' => \'0\',\n  \'defaultvalue\' => \'\',\n)','','-99','-99',0,0,0,0,0,0,0,0,55,0,0),(41,2,1,'username','用户名','','',0,20,'','','text','','','','',1,1,0,1,0,0,0,0,98,0,0),(42,2,1,'downfiles','本地下载','','',0,0,'','','downfiles','array (\n  \'upload_allowext\' => \'rar|zip\',\n  \'isselectimage\' => \'0\',\n  \'upload_number\' => \'10\',\n  \'downloadlink\' => \'1\',\n  \'downloadtype\' => \'1\',\n)','','','',0,0,0,1,0,1,0,0,8,0,0),(43,2,1,'downfile','镜像下载','','',0,0,'','','downfile','array (\n  \'downloadlink\' => \'1\',\n  \'downloadtype\' => \'1\',\n  \'upload_allowext\' => \'rar|zip\',\n  \'isselectimage\' => \'0\',\n  \'upload_number\' => \'1\',\n)','','','',0,0,0,1,0,1,0,0,9,0,0),(44,2,1,'systems','软件平台','<select name=\'selectSystem\' onchange=\"ChangeInput(this,document.myform.systems,\'/\')\">\r\n	<option value=\'WinXP\'>WinXP</option>\r\n	<option value=\'Vista\'>Windows 7</option>\r\n	<option value=\'Win2000\'>Win2000</option>\r\n	<option value=\'Win2003\'>Win2003</option>\r\n	<option value=\'Unix\'>Unix</option>\r\n	<option value=\'Linux\'>Linux</option>\r\n	<option value=\'MacOS\'>MacOS</option>\r\n</select>','',0,100,'','','text','array (\n  \'size\' => \'50\',\n  \'defaultvalue\' => \'Win2000/WinXP/Win2003\',\n  \'ispassword\' => \'0\',\n)','','','',0,1,0,1,0,1,1,0,14,0,0),(45,2,1,'copytype','软件授权形式','','',0,15,'','','box','array (\n  \'options\' => \'免费版|免费版\r\n共享版|共享版\r\n试用版|试用版\r\n演示版|演示版\r\n注册版|注册版\r\n破解版|破解版\r\n零售版|零售版\r\nOEM版|OEM版\',\n  \'boxtype\' => \'select\',\n  \'fieldtype\' => \'varchar\',\n  \'minnumber\' => \'1\',\n  \'cols\' => \'5\',\n  \'width\' => \'80\',\n  \'size\' => \'1\',\n  \'default_select_value\' => \'免费版\',\n)','','','',0,1,0,1,0,1,0,0,12,0,0),(46,2,1,'language','软件语言','','',0,16,'','','box','array (\n  \'options\' => \'英文|英文\r\n简体中文|简体中文\r\n繁体中文|繁体中文\r\n简繁中文|简繁中文\r\n多国语言|多国语言\r\n其他语言|其他语言\',\n  \'boxtype\' => \'select\',\n  \'fieldtype\' => \'varchar\',\n  \'minnumber\' => \'1\',\n  \'cols\' => \'5\',\n  \'width\' => \'80\',\n  \'size\' => \'1\',\n  \'default_select_value\' => \'简体中文\',\n)','','','',0,1,0,1,0,1,0,0,13,0,0),(47,2,1,'classtype','软件类型','','',0,20,'','','box','array (\n  \'options\' => \'国产软件|国产软件\r\n国外软件|国外软件\r\n汉化补丁|汉化补丁\r\n程序源码|程序源码\r\n其他|其他\',\n  \'boxtype\' => \'radio\',\n  \'fieldtype\' => \'varchar\',\n  \'minnumber\' => \'1\',\n  \'cols\' => \'5\',\n  \'width\' => \'80\',\n  \'size\' => \'1\',\n  \'default_select_value\' => \'国产软件\',\n)','','','',0,1,0,1,0,1,0,0,17,0,0),(48,2,1,'version','版本号','','',0,20,'','','text','array (\n  \'size\' => \'10\',\n  \'defaultvalue\' => \'\',\n  \'ispassword\' => \'0\',\n)','','','',0,1,0,0,0,1,1,0,13,0,0),(49,2,1,'filesize','文件大小','','',0,10,'','','text','array (\n  \'size\' => \'10\',\n  \'defaultvalue\' => \'未知\',\n  \'ispassword\' => \'0\',\n)','','','',0,1,0,0,0,1,1,0,14,0,0),(50,2,1,'stars','评分等级','','',0,20,'','','box','array (\n  \'options\' => \'★☆☆☆☆|★☆☆☆☆\r\n★★☆☆☆|★★☆☆☆\r\n★★★☆☆|★★★☆☆\r\n★★★★☆|★★★★☆\r\n★★★★★|★★★★★\',\n  \'boxtype\' => \'radio\',\n  \'fieldtype\' => \'varchar\',\n  \'minnumber\' => \'1\',\n  \'cols\' => \'5\',\n  \'width\' => \'88\',\n  \'size\' => \'1\',\n  \'default_select_value\' => \'★★★☆☆\',\n)','','','',0,1,0,1,0,1,0,0,17,0,0),(51,3,1,'allow_comment','允许评论','','',0,0,'','','box','array (\n  \'options\' => \'允许评论|1\r\n不允许评论|0\',\n  \'boxtype\' => \'radio\',\n  \'fieldtype\' => \'tinyint\',\n  \'minnumber\' => \'1\',\n  \'width\' => \'88\',\n  \'size\' => \'1\',\n  \'defaultvalue\' => \'1\',\n  \'outputtype\' => \'1\',\n  \'filtertype\' => \'0\',\n)','','','',0,0,0,0,0,0,0,0,54,0,0),(52,3,1,'template','内容页模板','','',0,30,'','','template','array (\n  \'size\' => \'\',\n  \'defaultvalue\' => \'\',\n)','','-99','-99',0,0,0,0,0,0,0,0,53,0,0),(53,3,1,'url','URL','','',0,100,'','','text','','','','',1,1,0,1,0,0,0,0,50,0,0),(54,3,1,'listorder','排序','','',0,6,'','','number','','','','',1,1,0,1,0,0,0,0,51,0,0),(55,3,1,'posids','推荐位','','',0,0,'','','posid','array (\n  \'cols\' => \'4\',\n  \'width\' => \'125\',\n)','','','',0,1,0,1,0,0,0,0,18,0,0),(56,3,1,'groupids_view','阅读权限','','',0,0,'','','groupid','array (\n  \'groupids\' => \'\',\n)','','','',0,0,0,1,0,0,0,0,19,0,0),(57,3,1,'inputtime','发布时间','','',0,0,'','','datetime','array (\n  \'fieldtype\' => \'int\',\n  \'format\' => \'Y-m-d H:i:s\',\n  \'defaulttype\' => \'0\',\n)','','','',0,1,0,0,0,0,0,1,17,0,0),(58,3,1,'pages','分页方式','','',0,0,'','','pages','','','-99','-99',0,0,0,1,0,0,0,0,16,0,0),(59,3,1,'relation','相关组图','','',0,0,'','','omnipotent','array (\n  \'formtext\' => \'<input type=\\\'hidden\\\' name=\\\'info[relation]\\\' id=\\\'relation\\\' value=\\\'{FIELD_VALUE}\\\' style=\\\'50\\\' >\r\n<ul class=\"list-dot\" id=\"relation_text\"></ul>\r\n<div>\r\n<input type=\\\'button\\\' value=\"添加相关\" onclick=\"omnipotent(\\\'selectid\\\',\\\'?m=content&c=content&a=public_relationlist&modelid={MODELID}\\\',\\\'添加相关文章\\\',1)\" class=\"button\" style=\"width:66px;\">\r\n<span class=\"edit_content\">\r\n<input type=\\\'button\\\' value=\"显示已有\" onclick=\"show_relation({MODELID},{ID})\" class=\"button\" style=\"width:66px;\">\r\n</span>\r\n</div>\',\n  \'fieldtype\' => \'varchar\',\n  \'minnumber\' => \'1\',\n)','','2,6,4,5,1,17,18,7','',0,0,0,0,0,0,1,0,15,0,0),(60,3,1,'thumb','缩略图','','',0,100,'','','image','array (\n  \'size\' => \'50\',\n  \'defaultvalue\' => \'\',\n  \'show_type\' => \'1\',\n  \'upload_maxsize\' => \'1024\',\n  \'upload_allowext\' => \'jpg|jpeg|gif|png|bmp\',\n  \'watermark\' => \'0\',\n  \'isselectimage\' => \'1\',\n  \'images_width\' => \'\',\n  \'images_height\' => \'\',\n)','','','',0,1,0,0,0,1,0,1,14,0,0),(61,3,1,'content','内容','<div class=\"content_attr\"><label><input name=\"add_introduce\" type=\"checkbox\"  value=\"1\" checked>是否截取内容</label><input type=\"text\" name=\"introcude_length\" value=\"200\" size=\"3\">字符至内容摘要\r\n<label><input type=\'checkbox\' name=\'auto_thumb\' value=\"1\" checked>是否获取内容第</label><input type=\"text\" name=\"auto_thumb_no\" value=\"1\" size=\"2\" class=\"\">张图片作为标题图片\r\n</div>','',0,999999,'','','editor','array (\n  \'toolbar\' => \'full\',\n  \'defaultvalue\' => \'\',\n  \'enablekeylink\' => \'1\',\n  \'replacenum\' => \'2\',\n  \'link_mode\' => \'0\',\n  \'enablesaveimage\' => \'1\',\n  \'height\' => \'\',\n  \'disabled_page\' => \'1\',\n)','','','',0,0,0,1,0,1,1,0,13,0,0),(62,3,1,'updatetime','更新时间','','',0,0,'','','datetime','array (\r\n  \'dateformat\' => \'int\',\r\n  \'format\' => \'Y-m-d H:i:s\',\r\n  \'defaulttype\' => \'1\',\r\n  \'defaultvalue\' => \'\',\r\n)','','','',1,1,0,1,0,0,0,0,12,0,0),(63,3,1,'description','摘要','','',0,255,'','','textarea','array (\r\n  \'width\' => \'98\',\r\n  \'height\' => \'46\',\r\n  \'defaultvalue\' => \'\',\r\n  \'enablehtml\' => \'0\',\r\n)','','','',0,1,0,1,0,1,1,1,10,0,0),(64,3,1,'title','标题','','inputtitle',1,80,'','请输入标题','title','','','','',0,1,0,1,1,1,1,1,4,0,0),(65,3,1,'keywords','关键词','多关键词之间用空格或者“,”隔开','',0,40,'','','keyword','array (\r\n  \'size\' => \'100\',\r\n  \'defaultvalue\' => \'\',\r\n)','','-99','-99',0,1,0,1,1,1,1,0,7,0,0),(66,3,1,'typeid','类别','','',0,0,'','','typeid','array (\n  \'minnumber\' => \'\',\n  \'defaultvalue\' => \'\',\n)','','','',0,1,0,1,1,1,0,0,2,0,0),(67,3,1,'catid','栏目','','',1,6,'/^[0-9]{1,6}$/','请选择栏目','catid','array (\n  \'defaultvalue\' => \'\',\n)','','-99','-99',0,1,0,1,1,1,0,0,1,0,0),(68,3,1,'status','状态','','',0,2,'','','box','','','','',1,1,0,1,0,0,0,0,55,0,0),(69,3,1,'readpoint','阅读收费','','',0,5,'','','readpoint','array (\n  \'minnumber\' => \'1\',\n  \'maxnumber\' => \'99999\',\n  \'decimaldigits\' => \'0\',\n  \'defaultvalue\' => \'\',\n)','','-99','-99',0,0,0,0,0,0,0,0,55,0,0),(70,3,1,'username','用户名','','',0,20,'','','text','','','','',1,1,0,1,0,0,0,0,98,0,0),(71,3,1,'pictureurls','组图','','',0,0,'','','images','array (\n  \'upload_allowext\' => \'gif|jpg|jpeg|png|bmp\',\n  \'isselectimage\' => \'1\',\n  \'upload_number\' => \'50\',\n)','','','',0,0,0,1,0,1,0,0,15,0,0),(72,3,1,'copyfrom','来源','','',0,0,'','','copyfrom','array (\n  \'defaultvalue\' => \'\',\n)','','','',0,0,0,1,0,1,0,0,8,0,0),(73,1,1,'islink','转向链接','','',0,0,'','','islink','','','','',0,1,0,0,0,1,0,0,30,0,0),(74,2,1,'islink','转向链接','','',0,0,'','','islink','','','','',0,1,0,0,0,1,0,0,30,0,0),(75,3,1,'islink','转向链接','','',0,0,'','','islink','','','','',0,1,0,0,0,1,0,0,30,0,0),(83,10,1,'birthday','生日','','',0,0,'','生日格式错误','datetime','array (\n  \'fieldtype\' => \'date\',\n  \'format\' => \'Y-m-d\',\n  \'defaulttype\' => \'0\',\n)','','','',0,0,0,0,0,1,1,0,0,0,0),(84,5,1,'thumb','标题图片',' ',' ',0,0,' ',' ',' ',' ',' ',' ',' ',0,0,0,0,0,0,0,0,0,0,0),(85,5,1,'title','房源名称',' ssssssss',' ',0,0,' ',' ',' ','',' ',' ',' ',0,0,0,0,0,0,0,0,0,0,0);

/*Table structure for table `tacms_news` */

CREATE TABLE `tacms_news` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `catid` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '所在频道id',
  `title` varchar(80) NOT NULL DEFAULT '' COMMENT '新闻标题',
  `thumb` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `keywords` char(40) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` mediumtext NOT NULL COMMENT '描述',
  `url` varchar(100) NOT NULL COMMENT '访问路径',
  `listorder` varchar(32) NOT NULL DEFAULT '0' COMMENT '排序字段',
  `islink` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否是推送文章',
  `updatetime` int(11) DEFAULT NULL,
  `createtime` int(11) DEFAULT NULL,
  `status` char(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `status` (`listorder`,`id`),
  KEY `listorder` (`catid`,`listorder`,`id`),
  KEY `catid` (`catid`,`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `tacms_news` */

insert  into `tacms_news`(`id`,`catid`,`title`,`thumb`,`keywords`,`description`,`url`,`listorder`,`islink`,`updatetime`,`createtime`,`status`) values (1,64,'33333333','','3333333333333333','<p>333333333333333333333333333</p>','','0',0,2012,2012,'1'),(2,64,'aa','','ff','a',' ','0',0,2012,2012,'1'),(3,64,'vvv','','v','<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;v&nbsp;&nbsp;&nbsp;<br /></p>','','0',0,2012,2012,'1'),(4,67,'a','','a','<p>a</p>','','0',0,NULL,1350028126,'1');

/*Table structure for table `tacms_news_counter` */

CREATE TABLE `tacms_news_counter` (
  `counter_id` int(11) NOT NULL,
  `max_update` datetime NOT NULL,
  PRIMARY KEY (`counter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

/*Data for the table `tacms_news_counter` */

/*Table structure for table `tacms_node` */

CREATE TABLE `tacms_node` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `title` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `remark` varchar(255) NOT NULL DEFAULT '节点',
  `sort` smallint(5) unsigned NOT NULL,
  `pid` smallint(6) unsigned NOT NULL,
  `level` tinyint(1) unsigned NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0',
  `group_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `level` (`level`),
  KEY `pid` (`pid`),
  KEY `status` (`status`),
  KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=124 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `tacms_node` */

insert  into `tacms_node`(`id`,`name`,`title`,`status`,`remark`,`sort`,`pid`,`level`,`type`,`group_id`) values (113,'update','更新',1,'节点',0,109,0,0,0),(112,'edit','修改',1,'节点',0,109,0,0,0),(111,'insert','插入',1,'节点',0,109,0,0,0),(110,'add','添加',1,'节点',0,109,0,0,0),(109,'Public','公共模块',1,'节点',999,0,0,0,0),(108,'Node','节点管理',1,'节点',4,101,0,0,0),(107,'Role','角色管理',1,'节点',3,101,0,0,0),(106,'Group','用户组',1,'节点',2,101,0,0,0),(105,'User','用户管理',1,'节点',1,101,0,0,0),(104,'Theme','主题管理',1,'节点',1,100,0,0,0),(102,'Category','栏目管理',1,'节点',1,99,0,0,0),(103,'Content','内容管理',1,'节点',2,99,0,0,0),(101,'Auth','权限管理',1,'节点',3,0,0,0,0),(100,'Theme','主题管理',1,'节点',2,0,0,0,0),(99,'Admin','内容管理',1,'节点',1,0,0,0,0),(114,'foreverdelete','删除',1,'节点',0,109,0,0,0),(115,'forbid','禁用',1,'节点',0,109,0,0,0),(116,'resume','恢复',1,'节点',0,109,0,0,0),(117,'Category','测试',-1,'节点',0,99,0,0,0),(118,'Home','房屋管理',1,'节点',0,0,0,0,0),(119,'Home','房屋管理',1,'节点',0,118,0,0,0),(120,'Theme','主题管理',1,'节点',0,99,0,0,0),(121,'HomeConfig','房屋管理配置',1,'节点',2,118,0,0,0),(122,'HomeType','房屋类型管理',1,'节点',3,118,0,0,0),(123,'HomeRegion','小区管理',1,'节点',4,118,0,0,0);

/*Table structure for table `tacms_picture` */

CREATE TABLE `tacms_picture` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `typeid` smallint(5) unsigned NOT NULL,
  `title` char(80) NOT NULL DEFAULT '',
  `style` char(24) NOT NULL DEFAULT '',
  `thumb` char(100) NOT NULL DEFAULT '',
  `keywords` char(40) NOT NULL DEFAULT '',
  `description` char(255) NOT NULL DEFAULT '',
  `posids` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `url` char(100) NOT NULL,
  `listorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `sysadd` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `islink` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `username` char(20) NOT NULL,
  `inputtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `status` (`status`,`listorder`,`id`),
  KEY `listorder` (`catid`,`status`,`listorder`,`id`),
  KEY `catid` (`catid`,`status`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

/*Data for the table `tacms_picture` */

/*Table structure for table `tacms_picture_counter` */

CREATE TABLE `tacms_picture_counter` (
  `counter_id` int(11) NOT NULL,
  `max_update` datetime NOT NULL,
  PRIMARY KEY (`counter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

/*Data for the table `tacms_picture_counter` */

/*Table structure for table `tacms_role` */

CREATE TABLE `tacms_role` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `pid` smallint(6) DEFAULT NULL,
  `status` tinyint(1) unsigned DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `ename` varchar(5) DEFAULT NULL,
  `create_time` int(11) unsigned NOT NULL,
  `update_time` int(11) unsigned NOT NULL,
  `site_id` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parentId` (`pid`),
  KEY `ename` (`ename`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `tacms_role` */

insert  into `tacms_role`(`id`,`name`,`pid`,`status`,`remark`,`ename`,`create_time`,`update_time`,`site_id`) values (9,'系统管理员',0,1,'1','1',1345190537,0,2),(10,'1',0,NULL,NULL,NULL,1349892847,0,0),(11,'1',0,NULL,NULL,NULL,1349892858,0,0),(12,'3',0,NULL,NULL,NULL,1349921023,0,0);

/*Table structure for table `tacms_role_category` */

CREATE TABLE `tacms_role_category` (
  `role_id` int(32) unsigned NOT NULL,
  `site_id` int(32) NOT NULL,
  `category_id` int(32) NOT NULL DEFAULT '-1',
  `int` int(32) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`int`),
  KEY `group_id` (`role_id`),
  KEY `user_id` (`site_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

/*Data for the table `tacms_role_category` */

insert  into `tacms_role_category`(`role_id`,`site_id`,`category_id`,`int`) values (3,1,-1,1),(1,4,-1,2),(2,3,-1,3),(7,2,-1,4);

/*Table structure for table `tacms_role_user` */

CREATE TABLE `tacms_role_user` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `role_id` smallint(6) unsigned NOT NULL,
  `user_id` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`role_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

/*Data for the table `tacms_role_user` */

insert  into `tacms_role_user`(`id`,`role_id`,`user_id`) values (1,9,1),(2,9,4);

/*Table structure for table `tacms_single_counter` */

CREATE TABLE `tacms_single_counter` (
  `counter_id` int(11) NOT NULL,
  `max_update` datetime NOT NULL,
  PRIMARY KEY (`counter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

/*Data for the table `tacms_single_counter` */

/*Table structure for table `tacms_single_page` */

CREATE TABLE `tacms_single_page` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `catid` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '所在频道id',
  `title` varchar(80) NOT NULL DEFAULT '' COMMENT '新闻标题',
  `thumb` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `keywords` char(40) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` mediumtext NOT NULL COMMENT '描述',
  `url` varchar(100) NOT NULL COMMENT '访问路径',
  `listorder` varchar(32) NOT NULL DEFAULT '0' COMMENT '排序字段',
  `islink` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否是推送文章',
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `status` (`listorder`,`id`),
  KEY `listorder` (`catid`,`listorder`,`id`),
  KEY `catid` (`catid`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `tacms_single_page` */

/*Table structure for table `tacms_site` */

CREATE TABLE `tacms_site` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(30) DEFAULT '',
  `dirname` char(255) DEFAULT '',
  `domain` char(255) NOT NULL DEFAULT '',
  `site_title` char(255) DEFAULT '',
  `keywords` char(255) DEFAULT '',
  `description` char(255) DEFAULT '',
  `catestruct` char(255) DEFAULT NULL COMMENT '站点下栏目的结构，以json形式保存',
  `themeid` smallint(6) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

/*Data for the table `tacms_site` */

insert  into `tacms_site`(`id`,`name`,`dirname`,`domain`,`site_title`,`keywords`,`description`,`catestruct`,`themeid`,`status`) values (1,'默认站点','','localhost','默认站点','默认站点','默认站点',NULL,1,1),(2,'a','a','www.a.com','a','a','',NULL,0,1),(3,'b','b','www.b.com','b','b','',NULL,0,1);

/*Table structure for table `tacms_site_layout` */

CREATE TABLE `tacms_site_layout` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `site_id` smallint(6) NOT NULL,
  `layout_id` smallint(6) NOT NULL,
  `isdefault` char(2) CHARACTER SET utf8 NOT NULL DEFAULT '1' COMMENT '是否为默认模板1：是，0：否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Data for the table `tacms_site_layout` */

insert  into `tacms_site_layout`(`id`,`site_id`,`layout_id`,`isdefault`) values (18,1,1,'1'),(19,1,15,'1'),(20,1,16,'1');

/*Table structure for table `tacms_theme` */

CREATE TABLE `tacms_theme` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(32) NOT NULL COMMENT '主题名称',
  `path` varchar(32) NOT NULL DEFAULT '/TPL' COMMENT '主题路径',
  `thumb` varchar(32) DEFAULT 'thumb.jpg' COMMENT '缩略图名称',
  `version` smallint(6) NOT NULL DEFAULT '1' COMMENT '主题版本',
  `public` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否对其他用户可见0：不可见，1：可见（需要系统管理员权限）',
  `site_id` smallint(6) NOT NULL COMMENT '所属的用户id',
  `descriptiion` varchar(1024) DEFAULT '说点什么吧：）',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:可用，-1禁用，0不可用',
  `isdefault` char(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

/*Data for the table `tacms_theme` */

insert  into `tacms_theme`(`id`,`name`,`path`,`thumb`,`version`,`public`,`site_id`,`descriptiion`,`status`,`isdefault`) values (1,'蓝色天空','bluesky','thumb.jpg',1,1,1,'说点什么吧：）',1,'1'),(3,'蓝色天空','bluesky','thumb.jpg',1,0,1,'说点什么吧：）',1,'0');

/*Table structure for table `tacms_user` */

CREATE TABLE `tacms_user` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(64) NOT NULL,
  `nickname` varchar(50) NOT NULL,
  `password` char(32) NOT NULL,
  `bind_account` varchar(50) NOT NULL,
  `last_login_time` int(11) unsigned NOT NULL DEFAULT '0',
  `last_login_ip` varchar(40) NOT NULL DEFAULT '1',
  `login_count` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `verify` varchar(32) NOT NULL,
  `email` varchar(50) NOT NULL,
  `remark` varchar(255) NOT NULL,
  `create_time` int(11) unsigned NOT NULL,
  `update_time` int(11) unsigned NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `type_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `info` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`account`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `tacms_user` */

insert  into `tacms_user`(`id`,`account`,`nickname`,`password`,`bind_account`,`last_login_time`,`last_login_ip`,`login_count`,`verify`,`email`,`remark`,`create_time`,`update_time`,`status`,`type_id`,`info`) values (1,'admin','管理员','21232f297a57a5a743894a0e4a801fc3','',1350005066,'127.0.0.1',1082,'8888','liu21st@gmail.com','备注信息',1222907803,1326266696,1,0,''),(4,'leader','领导','c444858e0aaeb727da73d2eae62321ad','',1345201489,'::1',92,'','','领导',1253514575,1254325705,1,0,'');

/*Table structure for table `tacms_widget` */

CREATE TABLE `tacms_widget` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `param` varchar(512) DEFAULT NULL COMMENT '微件参数',
  `action` varchar(16) DEFAULT NULL COMMENT '微件动作',
  `type` varchar(16) DEFAULT NULL COMMENT '微件类型，',
  `layoutid` int(32) DEFAULT NULL COMMENT '所属模板id',
  `position` varchar(32) DEFAULT NULL COMMENT '在模板中的位置',
  `name` varchar(32) DEFAULT NULL COMMENT '微件名称，与类名对应，list对应listwidget',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=138 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `tacms_widget` */

insert  into `tacms_widget`(`id`,`param`,`action`,`type`,`layoutid`,`position`,`name`) values (135,'{\"type\":\"homeregionid\",\"count\":8,\"style\":\"blue\",\"postid\":\"65\"}',NULL,'menu',18,'area1','Homeindex'),(134,'{\"type\":\"homeregionid\",\"count\":8,\"style\":\"blue\",\"postid\":\"65\"}',NULL,'menu',18,'area','Homeindex'),(111,'65',NULL,'menu',18,'adimage','HomeIndex'),(113,'{\"postid\":\"65\",\"style\":\"blue\"}',NULL,'menu',19,'salein','News'),(136,'{\"postid\":\"65\",\"style\":\"blue\"}',NULL,'menu',20,'labelselect','LabelSelect'),(137,'{\"postid\":\"65\",\"style\":\"blue\"}',NULL,'menu',20,'list','HomeList'),(117,'{\"postid\":\"65\",\"style\":\"blue\"}',NULL,'menu',18,'guiju','News'),(118,'{\"postid\":\"65\",\"style\":\"blue\"}',NULL,'menu',18,'news','News'),(119,'{\"postid\":\"65\",\"style\":\"blue\"}',NULL,'menu',18,'history','History'),(122,'aaaa',NULL,'menu',18,'search','Search');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
