<?php 
class OfferEmailWidget  extends Widget{
	/* (non-PHPdoc)
	 * @see Widget::render()
	 */
public function render($data) {
		// TODO Auto-generated method stub
		$widgetId = $data["id"];
		$widget = M("Widget")->find($widgetId);
		$param = $widget["param"];

		
		$content =  $this->renderFile('OfferEmail',array('list'=>'订阅组件添加成功！'));
		return $content;
	}

	public function edit($data){
		// 		if(!empty($data->id)){
		// 			$result = array();//临时变量存放修改功能的参数；
		// 			$widgetId = $data["id"];
		// 			$widget = M("Widget")->find($widgetId);
		// 			$param = $widget["param"];
		// 			$result->count = $param ->count;
		// 			$result->catid= $param->catid;//该部分暂且制作为单个栏目的图片轮换
		// 			$data->param = $result;
			
		// 		}
		if(!empty($data)){
	
			$content =  $this->renderFile('OfferEmailEdit',$data);
		}else{
			$content =  $this->renderFile('OfferEmailEdit',array("param"=>"''"));
		}
		return $content;
	}
	
	
	
	
	
	
}



?>