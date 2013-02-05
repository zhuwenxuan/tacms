<?php
//定义项目名称和路径
define('RUNTIME_ALLINONE', true);
define('APP_NAME', 'tacms');
define('APP_PATH', './');
define('THINK_PATH', 'ThinkPHP');
// define( 'STRIP_RUNTIME_SPACE' , false);
// define( 'NO_CACHE_RUNTIME' , True);
// 加载框架入口文件

//
require( THINK_PATH."/ThinkPHP.php");
App::run();