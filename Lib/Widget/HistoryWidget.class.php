<?php
class HistoryWidget extends Widget {
	public function render($data) {

//		$where["layoutid"] = $data["layoutid"];
//		$where["position"] = $data["position"];
//		$widget = M("Widget")->where($where)->find();
//		$param = json_decode($widget["param"]);
		$home_history = stripcslashes($_COOKIE ["home_history"]);
		// 判断是否存在
		$data["homes"] = unserialize($home_history);
		$content =  $this->renderFile('History',$data);
		echo $content;
	}
	public function edit($data){
//		$arr["volist"] = D("category")->where("site_id=".$_SESSION['_CURRENT_SITE']["id"])->select();
        $arr = array();
		return $this->renderFile('HistoryEdit',$arr);
	}
}
