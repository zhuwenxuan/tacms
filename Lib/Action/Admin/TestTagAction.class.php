<?php
class TestTagAction extends CommonAction {
	public function index() {
		import('@.Lib.TagLibArticle');
		$this->display();
	}
}
?>