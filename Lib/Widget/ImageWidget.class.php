<?php
class ImageWidget extends Widget {
	/**
	 * 图片滚动
	 */
	public function render($data) {
		$where ["layoutid"] = $data ["layoutid"];
		$where ["position"] = $data ["position"];
		$widget = M ( "Widget" )->where ( $where )->find ();
		$param = json_decode ( $widget ["param"] );
		$ad = D("Advertise")->getById($param->id);
		$data["image"]=explode(",", $ad['image']);
		$content =  $this->renderFile('Image',$data);
		return $content;
	}
	public function edit($data) {
		$data ["list"] = D ( "Advertise" )->where ( "type=2 AND status=1" )->select ();
		$content = $this->renderFile ( 'ImageEdit', $data );
		return $content;
	}
}
