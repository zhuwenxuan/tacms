<?php
class IndexAction extends Action {
	public function index() {
		$a = $_GET;
		if (empty ( $_GET )) {
			$type =  "Index";
		} else {
			$type = key ( $_GET );
			$type = ucfirst($type);
			$action = A ( "Index.".$type);
			$action->excute ();
		}
			$this->toLayout ($type);
		// dump($method); dump($_GET);
		// if (empty ( $_REQUEST ["contentid"] ) && empty ( $_REQUEST ["catid"]
		// ) && empty ( $_REQUEST ["hometype"] )) {
		// // 默认访问首页
		// $this->toIndex ();
		// } else if (! empty ( $_REQUEST ["catid"] ) && empty ( $_REQUEST
		// ["contentid"] )) {
		// // 访问列表页
		// $this->toList ( $_REQUEST ["catid"] );
		// } elseif (! empty ( $_REQUEST ["catid"] ) && ! empty ( $_REQUEST
		// ["contentid"] )) {
		// // 访问内容页
		// $this->toContent ( $_REQUEST ["catid"], $_REQUEST ["contentid"] );
		// } else if (! empty ( $_REQUEST ["hometype"] )) {
		// // $homeType是房屋类型：租房，售房
		// // 根据房屋访问房屋列表页
		// $this->toHomeType ();
		// } else if (! empty ( $_REQUEST ["homeid"] )) {
		// // 访问房屋详细页
		// $this->toHome ();
		// }
	}
	// 访问普通文章列表页
	private function toList($catid) {
		$cat = M ( "Category" )->find ( $catid );
		
		$model = M ( "Model" )->find ( $cat ["modelid"] );
		$count = M ( $model ["tablename"] )->where ( "catid=" . $catid )->count ();
		import ( "ORG.Util.Page" );
		$p = new Page ( $count, 10 );
		// $p->setConfig('header','篇记录');
		// $p->setConfig('prev',"<");
		// $p->setConfig('next','>');
		// $p->setConfig('first','<<');
		// $p->setConfig('last','>>');
		$page = $p->show ();
		$contentList = M ( $model ["tablename"] )->where ( "catid=" . $catid )->order ( 'createtime desc' )->limit ( $p->firstRow . ',' . $p->listRows )->select ();
		$this->assign ( "cList", $contentList );
		$this->assign ( "page", $page );
		$this->toLayout ( "list" );
	}
	// 访问普通文章内容页
	private function toContent($catid, $contentid) {
		$cat = M ( "Category" )->find ( $catid );
		$model = M ( "Model" )->find ( $cat ["modelid"] );
		$content = M ( $model ["tablename"] )->where ( "catid=" . $catid )->find ( $contentid );
		$this->assign ( "content", $content );
		$this->toLayout ( "content" );
	}
	private function toHomeList() {
		$this->toLayout ( "homeList" );
	}
	private function toHome() {
		// $homeid = $_GET["home"];
		// //判断是否已经存在
		// $homes = $_COOKIE["history_home"];
		
		// $homes = array();
		// if(isset($_COOKIE['history_home']))
		// {
		// $array = explode("||",$_COOKIE['history_home']);
		// foreach($array as $text)
		// {
		// $homes[] = explode(",", $text);
		// }
		// }
		// cookie("history",$_GET)
		include "HomeAction.class.php";
		$homeAction = new HomeAction ();
		$this->toLayout ( "home" );
	}
	// 根据站点和模板显示页面
	private function toLayout($type) {
		$host = explode ( ":", $_SERVER ["HTTP_HOST"] );
		$domain = $host [0];
		$port = $host [1];
		$site = D ( "Site" )->where ( "domain='" . $domain . "'" )->find ();
		if (empty ( $site )) {
			$this->error ( "页面不存在！" );
		}
		$where ['layoutStatus'] = 1;
		$where ['themeStatus'] = 1;
		$where ['siteStatus'] = 1;
		$where ['type'] = $type;
		$where ['domain'] = $domain;
		$layout = D ( "LayoutView" )->where ( $where )->find ();
		$filename = $layout ["filename"];
		$this->assign ( "layoutid", $layout ["id"] );
		$this->display ( $layout ["themePath"] . "@Index:" . "/" . $filename );
	}
}
?>