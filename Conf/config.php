<?php
if (! defined ( 'THINK_PATH' ))
	exit ();

$config = array(

/* 项目设定 */
		'APP_DEBUG' => true, // 是否开启调试模式
		'URL_MODEL' => 1, // 如果你的环境不支持PATHINFO 请设置为3
		'SHOW_PAGE_TRACE' => 1, // 显示调试信息
		'APP_GROUP_LIST' => 'Index,Admin,Auth,Public,Home,Content,Product,Theme,Member', // 项目分组设定,多个组之间用逗号分隔,例如'Home,Admin'
		'DEFAULT_GROUP' => 'Index', // 默认分组
		'DEFAULT_MODULE' => 'Index', // 默认模块名称
		'SHOW_RUN_TIME' => true, // 运行时间显示
		'SHOW_ADV_TIME' => true, // 显示详细的运行时间
		'SHOW_DB_TIMES' => true, // 显示数据库查询和写入次数
		'SHOW_CACHE_TIMES' => true, // 显示缓存操作次数
		'SHOW_USE_MEM' => true, // 显示内存开销
		
		'VAR_PAGE' => "pagenum",
		'PAGE_LISTROWS' => 10,
		
		
		'UPLOAD_PATH'=>"/Tpl/Uploads/",
		'SEPARATE'=>",",
)
;

$db = require 'Conf/db.php';
$theme = require 'Conf/theme.php';
$auth = require 'Conf/auth.php';
$search = require 'Conf/search.php';
return array_merge ( $config, $db, $theme, $auth, $search );
?>