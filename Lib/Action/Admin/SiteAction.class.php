<?php
class SiteAction extends CommonAction {
	public function siteAjaxList() { // 返回json 格式站点列表
		$result = M ( 'Site' )->select ();
		$data = json_encode ( $result );
		$this->ajaxReturn ( $result, "", 1 );
	}
	public function changeSite() {
		$changeSite = $_REQUEST ['id'];
		if (! empty ( $_REQUEST ['id'] )) {
			// $vo = M('site')->find($changeSite);
			foreach ( $_SESSION ['_SITE_LIST'] as $session ) {
				if ($session ['id'] == $changeSite) {
					$_SESSION ['_CURRENT_SITE'] = $session;
					break;
				}
			}
			redirect ( __APP__ . "/Admin" );
		}
	}
}
?>