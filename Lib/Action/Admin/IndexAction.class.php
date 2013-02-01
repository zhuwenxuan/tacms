<?php
class IndexAction extends Action {
	public function index() {
		if (! isset ( $_SESSION [C ( 'USER_AUTH_KEY' )] )) {
			$this->assign ( 'jumpUrl', C('USER_AUTH_GATEWAY'));
			$this->error ( '没有登录' );
		}
		import ( '@.ORG.RBAC' );
		$menu = RBAC::getMenu ();
		$this->assign ( 'menu', json_encode ( $menu ) );
		$this->display ();
	}
	public function getMenu() {
		import ( '@.ORG.RBAC' );
		$menu = RBAC::getMenu ( $_REQUEST ['id'] );
		echo json_encode ( $menu );
	}
}
?>