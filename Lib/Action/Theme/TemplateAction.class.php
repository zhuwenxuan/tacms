<?php
class TemplateAction extends CommonAction {
	public function index() {
		$path = str_replace ( "-", DIRECTORY_SEPARATOR, $_GET ["path"] );
		$path = str_replace ( DIRECTORY_SEPARATOR . DIRECTORY_SEPARATOR, DIRECTORY_SEPARATOR, $path );
		import ( '@.Util.File' );
		$local = $_SERVER ['DOCUMENT_ROOT'];
		// 模板主题路径
		$dir = File::getDir ( C ( "REAL_TEMP_PATH" ) . $path );
		$this->assign ( "path", $path );
		foreach ( $dir as $k => $v ) {
			$file [$k] ["path"] = $path . "-" . $v;
			$file [$k] ["name"] = $v;
		}
		$this->assign ( "file", $file );
		$this->display ( "Layout:index" );

	}
	public function delete() {
	}
	public function edit() {
		$this->display();
	}
	public function addwg() {
		$this->display();
	}

}
?>