<?php
class ContentAction extends Action {
	public function excute(){
		$contentid = $_GET ["content"];
		$content = D("News")->find($contentid);
		$this->assign("content",$content);
	}
}

?>