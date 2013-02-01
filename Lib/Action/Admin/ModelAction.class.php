<?php 
class ModelAction extends CommonAction {

	public function index(){
		
		$data = M ( 'model' );
		 $count = $data->count();
// 		导入分页类
		import("ORG.Util.Page");
// 		实例化分页类
		$p = new Page($count, 10);
// 		分页显示输出
		$page = $p->show();
// 		当前页数据查询
		$list = $data->order('modelid
		ASC')->limit($p->firstRow.','.$p->listRows)->select();
// 		赋值赋值
		$this->assign('page', $page);
		$this->assign('modelList', $list);
		$this->display ( "Layout:index" );
	}
	public function toInsert() {
		
		$this->display ( "Layout:index" );
		
	}



}

?>