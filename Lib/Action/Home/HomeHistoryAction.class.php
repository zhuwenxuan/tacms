<?php
class HomeHistoryAction extends CommonAction {
	public function _before_add() {
		$id = $_SESSION[C('USER_AUTH_KEY')];
		$this->assign("userid",$id);
		$data = M('User')->where(array('id'=>$id))->getField('realname');
		$this->assign("username",$data);
		$this->assign("homeid",$_REQUEST['homeid']);
	}
	function _filter(&$map) {
		$map['homeid']=$_REQUEST['homeid'];
	$this->assign("homeid",$_REQUEST['homeid']);
	}
}
?>