<?php
class MenuWidget extends Widget {
	public function render($data) {
        $obj = json_decode($data["param"],true);
        $categorys = M ( "category" )->where ( "( char_length( arrparentid ) - char_length( replace( arrparentid, '-', '' ) ) ) <=".($obj["menutype"]+1) )->select ();
        $arr = array();
        foreach($categorys as $key=>$val){
            $arr[$key] = array();
            $arr[$key]["name"] = $val["catname"];
            $arr[$key]["link"] = "catid=".$val["catid"];
        }
        $data["param"] = json_encode($arr);
        $content =  $this->renderFile('Menu',$data);
        return $content;
    }

}
