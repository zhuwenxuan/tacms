<?php
class ThemeAction extends CommonAction {
	function _filter(&$map){
		$map['site_id'] = $_SESSION['_CURRENT_SITE']['id'];
	}
	/**
	 * 导入主题
	 */
	public function import() {
		// 导入布局文件(包括布局，css，js)

	}
	/**
	 * 应用系统管理员创建的主题
	 */
	public function apply() {
		//在主题里插入数据
		$theme = M("Theme")->where("id=".$_REQUEST ["id"])->find();
		echo Session::get ( "userId" );
		$data['name'] = $theme['name'];
		$data['path'] = $theme['path'];
		$data['userId'] = Session::get ( "userId" );
		M("Theme")->add($data);
		$this->index();

	}
	/**
	 * 查看该主题下的布局
	 */
	public function listLayout(){
// 		$layout = $this->getChildTree("site_layout");
// 		$where['status'] = 1;
		$where['siteid'] = $_SESSION['_CURRENT_SITE']['id'];
		$where['themeid'] = $_GET['themeid'];
		$where['layoutStatus'] = 1;
		$where['themeStatus'] = 1;
		$where['siteStatus'] = 1;
		$layout = D("LayoutView")->where($where)->select();
		$this->assign("list",$layout);
		$this->display();
	}
	/**
	 * 可视化编辑布局
	 */
	public function editLayout() {
		$layoutid = $_GET ["id"];
		$where['id']=$layoutid;
		$layout = D("LayoutView")->where($where)->find();
		$this->assign ( "layoutid", $layoutid );
		$this->assign("modify","1");
		$this->display ( $layout["themePath"] . "@Index::".$layout["filename"] );
	}
	/**Í
	 * 编辑主题
	 */
	public function edit(){
		$themeId = $_REQUEST["id"];
		$this->redirect ( "/Layout/index", array("themeId"=>$themeId));
	}
	/**
	 * 发布主题（是其他用户可见）
	 * 需要系统主题管理的权限
	 */
	public function publish() {

	}
	/**
	 * 导出主题
	 */

	/**
	 * 选择/改变主题
	 */
}
?>