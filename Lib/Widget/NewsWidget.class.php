<?php
class NewsWidget extends Widget {
	public function render($data) {
		$where ["layoutid"] = $data ["layoutid"];
		$where ["position"] = $data ["position"];
		$widget = M ( "Widget" )->where ( $where )->find ();
		 $param = json_decode($widget["param"]);
		// $postid = $param->postid;
		 $data["style"] = $param->style;
		 $map["id"] = $param->postid;
		$category = M ( "category" )->where($map)->select ();
		// $modelid = $category["modelid"];
		// 暂时是文章模型
		$modelid = 1;
		$tname = M ( "model" )->where ( "id=" . $modelid )->find ();
		$postlist = M ( $tname ["tablename"] )->limit (5)->select ();
		//
		// $dataarr = array();
		foreach ( $postlist as $key => $val ) {
			$postlist [$key] ["url"] = "?content=".$val ["id"];
			$postlist [$key] ["createtime"] = toDate($val["createtime"],'Y-m-d');
		}
		$data ['postlist'] = $postlist ;
		$data ['more'] = "?category";
		$content = $this->renderFile ( 'News', $data );
		echo $content;
	}
	public function edit($data) {
		// $arr["volist"] =
		// D("category")->where("site_id=".$_SESSION['_CURRENT_SITE']["id"])->select();
        $data ["style"] = array (
                "blue" => "蓝色",
                "red" => "红色"
        );
        $map["status"]=1;
        $data ["cate"] =D("Category")->where($map)->select();
		return $this->renderFile ( 'NewsEdit', $data );
	}
}
