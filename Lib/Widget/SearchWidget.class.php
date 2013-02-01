<?php
class SearchWidget extends Widget {
	public function render($data) {
		$content =  $this->renderFile('Search',$data);
		return $content;
	}
	public function edit($data){
		$content =  $this->renderFile('SearchEdit',$data);
		return $content;
	}
}
