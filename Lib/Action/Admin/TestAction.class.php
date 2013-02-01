<?php

class TestAction extends Action {
	public function send($a){
		dump($a);
		$a = 3;
		echo "a=".$a;
	}
	public function index(){
		$b = array("aa"=>"bb");
		$this->send(&$b);
		dump($b);		
	}
	public function tp($a,$b){
		if(!empty($a))echo "a=".$a;
		if(!empty($b))echo "b=".$b;
	}
	public function test(){
		$this->tp( $b="b");
	}
}
?>