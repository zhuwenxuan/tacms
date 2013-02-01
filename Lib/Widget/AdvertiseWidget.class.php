<?php
class AdvertiseWidget extends Widget {
	public function render($data) {
		$where ["layoutid"] = $data ["layoutid"];
		$where ["position"] = $data ["position"];
		$widget = M ( "Widget" )->where ( $where )->find ();
		$param = json_decode ( $widget ["param"] );
		$data["ad"] = D("Advertise")->getById($param->id);
		$content =  $this->renderFile('Advertise',$data);
		return $content;
	}
	public function edit($data){
		$data["list"] = D("Advertise")->where("type=1 AND status=1")->select();
		$content =  $this->renderFile('AdvertiseEdit',$data);
		return $content;
	}
}
