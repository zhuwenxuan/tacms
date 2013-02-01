<?php
class ContentAction extends CommonAction {
	public function _before_add() {
		$type = $_REQUEST ['type'];
		$catid = $_REQUEST ['catid'];
		$this->assign ( 'type', $type );
		$this->assign ( 'catid', $catid );
	}
	public function edit(){
		$type = $_REQUEST ['type'];
		$id ['id'] = $_GET ['id'];
		$catid = $_REQUEST ['catid'];
		if ($id ['id'] != null) {
			$vo = M ( $type )->where ( $id )->find ();
			$this->assign ( "vo", $vo );
		}
		$this->assign ( 'type', $type );
		$this->assign ( 'catid', $catid );
		$this->display ();
	}
	//frame页面
	public function content(){
		$type = $_REQUEST ['type'];
		$catid = $_REQUEST ['catid'];
		$this->assign ( 'type', $type );
		$this->assign ( 'catid', $catid );
		$map['status'] = 1;
		$map['catid'] = $_REQUEST ['catid'];
		$model = D($type);
			$this->_list($model, $map);
		$this->_list($model, $map);
			$this->display ();
	}

	public function insert() {
		$type = $_REQUEST ['type'];
		$catid = $_REQUEST ['catid'];
		$data = D ( "News" );
		$data->create ();
		if (! empty ( $_FILES ) && ! empty ( $_FILES ['thumb'] ['name'] )) {
			// 如果有文件上传 上传附件
			$data ->thumb = $this->_upload ();
			// $this->forward();
		}
			$result =$data->add ();
		
		$this->assign ( 'type', $type );
		$this->assign ( 'catid', $catid );
		$flag = $_REQUEST ['flag'];
	
		if ($flag != null && $flag == 'singlePage') {
			$this->redirect ( "Content/singlePage/catid/" . $catid.'/type/'.$type );
		} else {
			$this->redirect ( "Content/content/catid/" . $catid . "/type/" . $type );
		}
	}
	public function update(){
		$type = $_REQUEST ['type'];
		$catid = $_REQUEST ['catid'];
		$data = D ( $type );
		$data->create ();
		if (! empty ( $_FILES ) && ! empty ( $_FILES ['thumb'] ['name'] )) {
			// 如果有文件上传 上传附件
			$data ->thumb = $this->_upload ();
			// $this->forward();
		}
		
			$data->save ();
		
		$flag = $_REQUEST ['flag'];
		
		if ($flag != null && $flag == 'singlePage') {
			$this->redirect ( "Content/singlePage/catid/" . $catid.'/type/'.$type );
		} else {
			$this->redirect ( "Content/content/catid/" . $catid . "/type/" . $type );
		}
		
		
	}
	public function foreverdelete() {
		$type = $_REQUEST ['type'];
		$data = M ( $type );
		$id = $_REQUEST ['id'];
		$catid = $_REQUEST ['catid'];
		$result = $data->where ( 'id=' . $id )->delete ();
// 		import ( "@.common.SphinxCommon" );
// 		SphinxCommon::sphinxRemove($type, $id);
		$this->redirect ( "Content/content/catid/" . $catid . "/type/" . $type );
	}

	public function index() {
	
		$this->display ( "Admin:Content:index" );
	}
	public function weclome(){
		$this->display ();
	}
	// 文件上传
	protected function _upload() {
		import ( "ORG.Net.UploadFile" );
		import ( "ORG.Util.Image" );
		// 导入上传类
		$upload = new UploadFile ();
		// 设置上传文件大小
		$upload->maxSize = 3292200;
		// 设置上传文件类型
		$upload->allowExts = explode ( ',', 'jpg,gif,png,jpeg' );
		// 设置附件上传目录
		$upload->savePath = 'Tpl/Uploads/';
		// 设置需要生成缩略图，仅对图像文件有效
		$upload->thumb = true;
		// 设置引用图片类库包路径
		$upload->imageClassPath = 'ORG.Util.Image';
		// 设置需要生成缩略图的文件后缀
		$upload->thumbPrefix = 'm_,s_'; // 生产2张缩略图
		                                // 设置缩略图最大宽度
		$upload->thumbMaxWidth = '400,100';
		// 设置缩略图最大高度
		$upload->thumbMaxHeight = '400,100';
		// 设置上传文件规则
		$upload->saveRule = uniqid;
		// 删除原图
		$upload->thumbRemoveOrigin = true;
		if (! $upload->upload ()) {
			// 捕获上传异常
			$this->error ( $upload->getErrorMsg () );
		} else {
			// 取得成功上传的文件信息
			$uploadList = $upload->getUploadFileInfo ();
			
			// 给m_缩略图添加水印, Image::water('原文件名','水印图片地址')
			Image::water ( $uploadList [0] ['savepath'] . 'm_' . $uploadList [0] ['savename'], '../Public/Images/logo2.png' );
			return $uploadList [0] ['savename'];
		}
	
	}
	/**
	 * 单页栏目页
	 */
	public function singlePage() {
		$id = $_REQUEST ['id'];
		$type = $_REQUEST ['type'];
		if ($id != null && $id != "") {
			$data = M ( 'single_page' )->where ( 'catid=' . $id )->find ();
			$this->assign ( 'vo', $data );
			$this->assign ( 'content', "Admin:Content:singlePage" );
		}
		$this->assign ( 'catid', $id );
		$this->assign ( 'type', $type );
		$this->display ( "Admin:Content:singlePage" );
	}

}
?>