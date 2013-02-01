<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>
<html>
<head>
<title>页面提示</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv='Refresh' content='{$waitSecond};URL={$jumpUrl}'>
<style>
html, body{margin:0; padding:0; border:0 none;font:14px Tahoma,Verdana;line-height:150%;background:white}
.titlebar{
	background: url(/Public/images/alert1.jpg) repeat-x;
width: 490px;
height: 27px;
font: bold 14px 宋体;
color: white;
text-align: left;
padding: 9px 0px 0px 10px;
	
}
.alertimg{
	background-image:url(/Public/images/alert2.png);
float:left;
	width:100px;
	height:129px;
}
a{text-decoration:none; color:#174B73; border-bottom:1px dashed gray}
a:hover{color:#F60; border-bottom:1px dashed gray}
div.message{margin:10% auto 0px auto;clear:both;border:1px solid rgb(35,123,255);background-color:rgb(252,253,253);text-align:center; width:500px;}
span.wait{color:blue;font-weight:bold}
span.error{color:red;font-weight:bold}
span.success{color:blue;font-weight:bold}
div.msg{float: left;
padding-top: 40px;
width: 385px;
height: 60px;}
.tip{height: 30px;}
</style>
</head>
<body>
<div class="message">
	<div class="titlebar">提示信息：</div>
	<div style="padding:5px;">
	<div class="alertimg"></div>
	<div class="msg">
	<present name="message" >
	<span class="success">{$msgTitle}{$message}</span>
	<else/>
	<span class="error">{$msgTitle}{$error}</span>
	</present>
	</div>
	<div style="clear:both;"></div>
	</div>
</div>
</body>
</html>