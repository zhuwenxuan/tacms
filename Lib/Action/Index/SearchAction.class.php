<?php
class SearchAction extends Action {
	public function index() {
		import ( "@.common.SphinxCommon" );
		
		$word = $_REQUEST ['word'];
		$word = '后台';
		// $siteid = $_REQUEST ['siteid'];
		// $word= 1;
		$siteid = 1;
		$sc = new SphinxCommon();
		$data = $sc->sphinxSearchCount ( "*", "后台", 1 ); // 调用sphinx
		                                                       // $ids =
		                                                       // join(',',array_keys($res['matches']));
		                                                       
		// echo '发的身份';
		$count = count ( $data ['matches'] );
		
// 		import ( "ORG.Util.Page" );
		
// 		// 实例化分页类
		import("@.ORG.Page");
		$p = new Page ( $count, 10 );
		$page = $p->show ();
		$list = $sc->sphinxSearchPage ( "*", $word, $p->firstRow, $p->listRows, $siteid );
		// $this->assign ( 'page', $page );
		$this->assign( 'result', $list['matches']);
		dump($list);
		// $this->display ( "Index:Search:index");
	}
}

?>