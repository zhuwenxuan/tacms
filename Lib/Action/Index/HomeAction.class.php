<?php
class HomeAction extends Action {
	public function excute() {
		$homeid = $_GET ["home"];
		$map ["id"] = $homeid;
		$home = D ( "Home" )->where ( $map )->find ();
		//UPLOAD_PATH
		//SEPARATE
		$this->addHistory ( $home );
		$thumbs = explode(C("SEPARATE"), $home["thumb"]);
        $home["thumb"]="";
		foreach ($thumbs as $key =>$thumb){
			$home["thumb"].=C("UPLOAD_PATH").$thumb.C("SEPARATE");
			$thumbs[$key] = C("UPLOAD_PATH")."m_".$thumb;
		}
		$home["thumb"] = substr($home["thumb"],0,strlen($home["thumb"])-strlen(C("SEPARATE")));
		$user = D("User")->find($home["userid"]);
		$user["avatar"] = C("UPLOAD_PATH")."m_".$user["avatar"];
		$region = D("home_region")->find($home["homeregionid"]);
		
		$this->assign("thumbs",$thumbs);
		$this->assign ( "home", $home );
		$this->assign ( "user", $user );
		$this->assign ( "region", $region );
	}
	private function addHistory($home, $length = 3) {
		// 1|新房子|111.jpg,2|老房子|222.jpg
		// echo urlencode("潘家园70平一个有美、有");
		// setcookie("home_history","1");
		$home_history = stripslashes($_COOKIE ["home_history"]);
		$homes = unserialize ( $home_history );
		// 判断是否存在
		if (empty ( $homes )) {
			$homes = array ();
		}
		$thumb = explode ( C ( "SEPARATE" ), $home ["thumb"] );
		$data ["thumb"] =C('UPLOAD_PATH').'s_'. $thumb [0];
		$data ["title"] = $home ["title"];
		$data ["url"] = "?home=".$home["id"];
		if (! in_array ( $data, $homes )) {
			array_unshift ( $homes, $data );
			if (count ( $homes ) > $length) {
				$homes = array_slice ( $homes, 0, $length );
			}
			setcookie ( "home_history", serialize ( $homes ) );
		}
		// setcookie("home_history","");
		// 如果未加入，则在首位加入
		// if(!strstr($home_history, $newhome)){
		// if(!empty($home_history)){
		// $home_history = C("SEPARATE").$home_history;
		// }
		// $home_history = $newhome.$home_history;
		// $history_array = explode(C("SEPARATE"), $home_history);
		// while(count($history_array)>$length){
		// array_pop($history_array);
		// $home_history = implode(C("SEPARATE"), $history_array);
		// }
		// setcookie("home_history",$home_history);
		// }
	}
}

?>