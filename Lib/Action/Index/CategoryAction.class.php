<?php
class CategoryAction extends Action {
	public function excute(){
// 		$cat = M ( "Category" )->find ( $_REQUEST["category"] );
		
// 		$model = M ( "Model" )->find ( $cat ["modelid"] );
//测试
		$model ["tablename"] = "News";
		$count = M ( $model ["tablename"] )->where ()->count ();
		import ( "ORG.Util.Page" );
		$p = new Page ( $count, 10 );
		// $p->setConfig('header','篇记录');
		// $p->setConfig('prev',"<");
		// $p->setConfig('next','>');
		// $p->setConfig('first','<<');
		// $p->setConfig('last','>>');
		$page = $p->show ();
		$contentList = M ( $model ["tablename"] )->where ()->order ( 'createtime desc' )->limit ( $p->firstRow . ',' . $p->listRows )->select ();
		foreach ($contentList as $key => $content){
			$contentList[$key]["url"] = "?content=".$content["id"];
		}
		$this->assign ( "contentList", $contentList );
		$this->assign ( "page", $page );
	}
}

?>