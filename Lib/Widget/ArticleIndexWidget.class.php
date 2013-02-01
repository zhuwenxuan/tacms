<?php
class ArticleIndexWidget extends Widget {
	public function render($data) {

		$where["layoutid"] = $data["layoutid"];
		$where["position"] = $data["position"];
		$widget = M("Widget")->where($where)->find();
		$param = json_decode($widget["param"]);
        $postid = $param->postid;
        $data["style"] = $param->style;
         $category = M("category")->where("id=".$postid)->find();
         $modelid = $category["modelid"];
         $tname = M("model")->where("id=".$modelid)->find();
         $postlist = M($tname["tablename"])->select();

        $dataarr = array();
        foreach($postlist as $key=>$val){
            $dataarr[$key]["img"] = $val["img"];
            $dataarr[$key]["href"] = $val["url"];
            $dataarr[$key]["area"] = $val["homeregionid"];
            $dataarr[$key]["price"] = $val["price"];
            $dataarr[$key]["type"] = $val["hometype"];
        }
        $data['postlist']= json_encode($dataarr);
		$content =  $this->renderFile('HomeIndex',$data);
		echo $content;
	}
	public function edit($data){
		$arr["volist"] = D("category")->where("site_id=".$_SESSION['_CURRENT_SITE']["id"])->select();
		return $this->renderFile('HomeIndexEdit',$arr);;
	}
}
