<?php
class ArticleListWidget extends Widget {
	public function render($data) {
		$widgetId = $data["id"];
		$widget = M("Widget")->find($widgetId);
		$param = $widget["param"];
		$content =  $this->renderFile('articlList',$data);	
		return $content;
	}
    public function edit($data){

    		$content =  $this->renderFile('AdimageEdit',$data);
    		return $content;
    	}

}
