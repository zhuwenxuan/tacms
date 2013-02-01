<?php
class GroupAction extends CommonAction {
	public function _before_add() {
		$this->assign ( "pid", $_GET ['pid'] );
	}
	public function index() {
		$treeList = $this->getChildTree ();
		$this->assign ( 'list', $treeList );
		Cookie::set('_currentUrl_', __SELF__);
		$this->display ();
	}
	public function showGroupList() {
		$pid = $_REQUEST ['id'];
		$resultList = array ();
		if ($pid == null || $pid == "") {
			$result ["id"] = 0;
			$result ["name"] = '组织机构';
			$result ["isParent"] = true;
			$resultList [] = $result;
		} else {
			$map ["pid"] = $pid;
			$map["site_id"] = $_SESSION['_CURRENT_SITE']['id'];
			$groups = M ( "group" )->where ( $map )->select ();
			foreach ( $groups as $key => $group ) {
				$result = M ( 'group' )->where ( 'pid = ' . $group ['id'] )->count () > 0 ? true : false;
				$groups [$key] ['isParent'] = $result;
			}
			$resultList = $groups;
		}
		$data = json_encode ( $resultList );
		echo $data;
		// $this->ajaxReturn ( $data,"",1);
	}
}
?>