
<?php
class CategoryAction extends CommonAction {
	public function add() {
		$modelList = M ( 'model' )->select ();
		$this->assign ( "modelList", $modelList );
		
		
		if ($_REQUEST ['pid'] == '0') {
			$data = array ();
			$data ['id'] = 0;
			$data ['name'] = '首页';
			// $modelList = M ( 'model' )->select ();
			$this->assign ( "modelList", $modelList );
			$this->assign ( 'parentvo', $data );
		} else {
			$data2 = D ( 'Category' )->Relation ( true )->where ( array ('id' => $_REQUEST ['pid'] ) )->find ();
			$this->assign ( 'parentvo', $data2 );
		}
		$codition ['type'] = 'list';
		$condition = $_SESSION['_CURRENT_SITE'][id];
		$list = M ( 'site_layout' )->join ( 'tacms_layout on layoutid = tacms_layout.id' )->where ( 'siteid=' . $condition . ' and tacms_layout.type="list"' )->field ( 'tacms_site_layout.id as sitelayoutid,imageurl' )->select ();
		$this->assign ( 'list', $list );
		$listcontent = M ( 'site_layout' )->join ( 'tacms_layout on layoutid = tacms_layout.id' )->where ( 'siteid=' . $condition . ' and tacms_layout.type="content"' )->field ( 'tacms_site_layout.id as sitelayoutid,imageurl' )->select ();
		$this->assign ( 'listcontent', $listcontent );
		$this->display ();
	}
	public function edit() {
		$data = M ( 'category' )->select ();
		$id ['id'] = $_GET ['catid'];
		$vo = D ( 'Category' )->Relation ( true )->where ( $id )->find ();
		$this->assign ( "categoryList", $data );
		$this->assign ( "vo", $vo );
		$condition = $condition = $_SESSION['_CURRENT_SITE'][id];
		$list = M ( 'site_layout' )->join ( 'tacms_layout on layoutid = tacms_layout.id' )->where ( 'siteid=' . $condition . ' and tacms_layout.type="list"' )->field ( 'tacms_site_layout.id as sitelayoutid,imageurl' )->select ();
		$this->assign ( 'list', $list );
		$listcontent = M ( 'site_layout' )->join ( 'tacms_layout on layoutid = tacms_layout.id' )->where ( 'siteid=' . $condition . ' and tacms_layout.type="content"' )->field ( 'tacms_site_layout.id as sitelayoutid,imageurl' )->select ();
		$this->assign ( 'listcontent', $listcontent );
		// 遍历树形栏目结构
			$this->assign ( 'categoryList', $this->getChildTree() );
		$this->assign ( 'categorytree', $this->temp );
		$this->display ();
	}
	/*
	 * 得到栏目列表
	 */
	public function getCategoryTree(){
		$siteid = $_REQUEST['layoutid'];
		$this->doManageCategory($siteid);
		echo json_encode($this->temp);
		
	}
// 	public function update() {//更新方法
// 		$data = D ( 'category' );
// 		// $oldpid = $_REQUEST ['oldpid'];
// 		$data->create ();
// 		$oldpid = $_REQUEST ['oldpid'];
// 		$order = $data->pid;
// // 		$oldOrder = $oldpid;
// 		$id = $data->catid;
// 		$data->save ();

// 		// 		if($oldpid != $data->pid){//栏目移动逻辑
// 		// 		$condition ['catid'] = $id;
// 		// 		// $data->save ( $condition );
// 		// 		$data2 = M ( 'category' );
// 		// 		$data2 = $data2->where ( $condition )->find ();
// 		// 		$flag2 = $data2 ['arrpid'];
// 		// 		$flag = $data2 ['arrpid'] . '-' . $oldOrder;
// 		// 		$length1 = strlen ( $flag );
// 		// 		$model = new Model ();
// 		// 		$sql = "UPDATE tacms_category SET
// 		// 		arrpid=CONCAT('$flag2','-$order',SUBSTRING(arrpid,$length1+1))
// 		// 		WHERE arrpid LIKE '$flag%' ";
// 		// 		$model->execute ( $sql );
// 		// 		}

// 		$this->redirect ( "Category/index" );

// 	}
	public function insert() {//添加方法
		$data = D ( 'category' );
		$data->create ();
		$data->url = '';
		$data->hits = 0;
		$data->ismenu = 0;
		$data->sethtml = 1;
		$data->site_id =  $_SESSION['_CURRENT_SITE'][id];
		$data->description = '';
		$data->add ();
		$this->redirect ( "Category/index" );
	}
// 	public function foreverdelete() {//删除方法
// 		$data = M ( 'category' );
// 		$id = $_REQUEST ['id'];
// 		$result = $data->where ( 'catid=' . $id )->delete ();
// 		$this->redirect ( "index" );
// 	}
	public $temp = array (); // 栏目有序列表
	public $tempIndex = array (); // 数据库中无序栏目列表
	public function doManageCategory($siteid) {
		$list = D ( 'category' )->where('siteid = '.$siteid)->order('listorder+0 asc')->select (); // 从数据库读取全部数据

		foreach ( $list as $key => $value ) {
			$size = count ( explode ( '-', $value ['arrpid'] ) );
			$flag = "&nbsp;&nbsp;&nbsp;";
			for($i = 1; $i < $size; $i ++) {

				$flag = "&nbsp;&nbsp;&nbsp;&nbsp;" . $flag;
					
			}
			$list [$key] ['listorder'] = ( int ) $value ['listorder'];
			$list [$key] ['catname'] = $flag . '|--' . $value ['catname'];
			array_push($this->tempIndex, $list [$key]);
		}

		$this->doOrderCategory ( 0 );
		// return $list;
	}
	/**
	 * 判断是否有根节点
	 */
	public function doCheckHaveSon($flag) {
		$result = true;
		foreach($this->tempIndex as $key => $value ) {
			if ($this->tempIndex[$key] ['pid'] == $flag) {
				$result = false;
				break;
			}
		}
		return $result;
	}
	public function doOrderCategory($flag) {
		foreach ( $this->tempIndex as $key => $value ) {
			if ($this->tempIndex [$key] ['pid'] == $flag) {
				array_push ( $this->temp, $this->tempIndex [$key] ); // 添加父节点
				// 				array_
				if (!$this->doCheckHaveSon ( $this->tempIndex [$key] ['catid'] )) { // 判断是否是根节点
					// 					array_push ( $this->temp, $this->tempIndex [$key] ); // 添加子节点

					// 				} else {
					$this->doOrderCategory ( $this->tempIndex [$key] ['catid']  );
				}
					
			}
		}

	}

	public function index() {

		$this->assign ( 'categoryList', $this->getChildTree() );
		$this->display ();
	}

	public function showCategoryListAjax() {
		$catid = $_REQUEST ['id'];
		$resultList = array ();
		if ($catid == null || $catid == "") {
			$result->id = 0;
			$result->name = '首页';
			$result->isParent = true;
			$resultList [] = $result;
		} else {
			$temp = array ();
			// $flag = M('category') ->join('category on category.modelid =
			// tacms_model.modelid')->where('category.pid =
			// '.$catid)->filed('category.catid as id ,category.catname as
			// name,tacms_model.tablename as type,category.modelid')->select();
				
			$Model = new Model ();
			$sql = 'SELECT a.modelid AS modelid,a.type as cattype ,b.tablename AS type,a.name AS name,a.id AS id FROM tacms_category a LEFT JOIN tacms_model b ON
 a.modelid = b.id WHERE a.pid =' . $catid;
				
			$flag = $Model->query ( $sql );
				
			foreach ( $flag as $key => $value ) {
				// $temp[$key]['id'] = $flag[$key]['id'];
				$result = M ( 'Category' )->where ( 'pid = ' . $flag [$key] ['id'] )->count () > 0 ? true : false;

				$flag [$key] ['isParent'] = $result;
				// $temp[$key]['name'] = $flag[$key][''];
				// $temp[$key]['modelid'] = $flag[$key]['modelid'];
				// $temp[$key]['tablename'] = $flag[$key]['tablename'];
					
			}
			$resultList = $flag;
		}
		$data = json_encode ( $resultList );
		echo $data;
		// $this->ajaxReturn ( $data,"",1);

	}
	public function updateOrder() {
		$order = $_REQUEST ['sort'];
		// 		$oldOrder = $_REQUEST ['oldOrder'];
		$id = $_REQUEST ['id'];
		// 处理为000字符串
		// 		$oldOrder = "000" . $oldOrder;
		// 		$length = strlen ( $oldOrder );
		// 		$oldOrder = substr ( $oldOrder, $length - 3, $length );
		// 		$order = "0" . $order;
// 		$length2 = strlen ( $order );
		// 		$order = substr ( $order, $length2 - 1, $length2 );
		$data = M ( 'category' );
		$condition ['sort'] = $order;
		$condition ['id'] = $id;
		$data->save ( $condition );
		// 		$data2 = M ( 'category' );
		// 		$data2 = $data2->where ( 'catid=' . $id )->find ();
		// 		$flag2 = $data2 ['arrpid'];
		// 		$flag = $data2 ['arrpid'] . '-' . $oldOrder;
		// 		$length1 = strlen ( $flag );
		// 		$model = new Model ();
		// 		$sql = "UPDATE tacms_category SET arrpid=CONCAT('$flag2','-$order',SUBSTRING(arrpid,$length1+1)) WHERE arrpid LIKE '$flag%' ";
		// 		$model->execute ( $sql );
	}
	public function findModelFiledId (){
		$catid =$_REQUEST['catid'];
		$category = D('Category')->relation(true)->find($catid);
		$modelFileds = M('ModelField')->where(array('modelid'=>$category['model']['id'],'siteid'=>$category['siteid']))->select();
		echo json_encode($modelFileds);
	}
}
?>