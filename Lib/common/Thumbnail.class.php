<?php
class Thumbnail {
	// $url = 'http://www.ws99.com'; //抓取百度
	// echo snapshot($url); //输出结果为图片地址
	// echo snapshot($url, './ws99.png'); //将图片保存至本地baidu.png, 输出内容图片大小
	
	/**
	 * 生成网页快照
	 *
	 * @param $url string 截图地址
	 * @param $fileName string 截图名称
	 *       	 
	 *       	
	 */
	public static function snapshot($url,$fileName) {
		$commond = '/usr/local/cutyCapt/xvfb-run.sh  -f ./.Xauthority /usr/local/cutyCapt/CutyCapt --url='.$url.' --out='.$fileName;
		system($commond);//执行centos命令
		
	}
}
?>