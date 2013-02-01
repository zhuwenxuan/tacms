<?php
class HomeRegionAction extends CommonAction {
	public function index(){
		$this->assign ( 'list', $this->getChildTree() );
		Cookie::set('_currentUrl_', __SELF__);
		$this->display ();
	}

	public function _before_add() {
		$data = array();
		if($_GET['pid']!='0'){
		$data = D('HomeRegion')->getById($_GET['pid']);
	}else{
		
		$data['pid']='0';
		$data['name']='首页';
	}
		$this->assign("parentVO",$data);
	}
	public function _before_edit() {
		$data = '首页';
		if($_GET['pid']!='0'){
			$name = D('HomeRegion')->getById($_GET['pid']);
			$data = $name['name'];
		}
		$this->assign("parentName",$data);
	}
	public function getHomeRegion(){
		$id = $_REQUEST["id"];
		$vo = D("HomeRegion")->getById($id);
		exit ( json_encode ( $vo ) );
	}
}
?>