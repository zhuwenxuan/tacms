<?php
class LayoutAction extends Action {
	// public function index() {
	// import ( 'ORG.Io.Dir' );
	// // 根据所选的布局类型，展示此类型下的所有布局
	// $ltype = $_GET ["ltype"];
	// if (empty ( $ltype )) {
	// $ltype = "index";
	// }
	// //根据选定的主题，查询之下的布局（主题为空则提示失败）
	// $themeId = $_REQUEST["themeId"];
	// //根据主题id查询该定制的主题的实例
	// $theme = M("Theme")->where("id = ".$themeId)->find();
	// //取得该主题下的布局模板（静态页面）
	// $themePath = new Dir(TMPL_PATH.$theme["path"]."/index");
	// $layouts = array();
	// foreach ($themePath as $dir){
	// if(strlen(strstr($dir['filename'],$ltype))>0){
	// array_push($layouts,$dir['filename']);
	// }
	// };
	
	// //取得该主题下的定制后的模板数据
	// $layoutcats = M ( "layout" )->field ( "type" )->distinct ( true )->select
	// ();
	// $this->assign ( "layouts", $layouts );
	// // 查找该站点，该类型下的所有布局
	// $siteid = Session::get ( "userSiteid" );
	// $site_layout = M ( 'site_layout' )->where ( 'siteid=' . $siteid . ' and
	// layoutType="' . $ltype . '" and themeid='.$themeId)->select ();
	// // 页面赋值
	// $this->assign ( "userLayout", $site_layout );
	// $this->assign ( "layoutcats", $layoutcats );
	// $this->assign ( "pname", "系统管理" );
	// $this->assign ( "name", "布局管理" );
	// $this->assign ( 'left', "/Admin/Layout/left" );
	// $this->assign ( 'content', "/Admin/Layout/index" );
	
	// // 跳转显示页面
	// $this->display ( "Admin:Index:index" );
	// }
	/**
	 * 应用布局
	 */
	public function apply() {
		$userSiteid = Session::get ( "userSiteid" );
		$layoutid = $_GET ["id"];
		// 查找当前布局类型
		$layout = M ( "layout" )->where ( "id=" . $layoutid )->find ();
		$data ["layoutType"] = $layout ["type"];
		$data ["siteid"] = $userSiteid;
		$data ["layoutid"] = $layoutid;
		
		// 如果未设置过当前类型的布局，则该布局为默认布局
		$otherLayout = M ( "Site_layout" )->where ( $data )->select ();
		if (empty ( $otherLayout )) {
			$data ["isdefault"] = 1;
		} else {
			$data ["isdefault"] = 0;
		}
		// 保存布局
		$layout = M ( "site_layout" )->add ( $data );
		// 跳转到布局列表页面
		$this->redirect ( "/Layout/index/ltype/" . $_GET ["ltype"] );
	}
	
	/**
	 * 设置默认布局
	 */
	public function setDefault() {
		$layoutid = $_GET ["id"];
		$siteid = Session::get ( "userSiteid" );
		$ltype = $_GET ["ltype"];
		$data ["isdefault"] = 0;
		$sc_old ["siteid"] = $siteid;
		$sc_old ["layoutType"] = $ltype;
		$sc_old ["isdefault"] = 1;
		M ( "Site_layout" )->where ( $sc_old )->save ( $data );
		$data ["isdefault"] = 1;
		M ( "Site_layout" )->where ( 'id=' . $layoutid )->save ( $data );
		$this->redirect ( "/Layout/index/ltype/" . $ltype );
	}
	/**
	 * 移除已经应用布局
	 */
	public function delete() {
		$layoutid = $_GET ["id"];
		M ( "Site_layout" )->where ( "id=" . $layoutid )->delete ();
		$this->redirect ( "/Layout/index/" );
	}
	
	/**
	 * 在可视化编辑布局中添加widget
	 */
	public function addWidget() {
		$data ["layoutid"] = $_REQUEST ["layoutid"];
		$data ["param"] = stripslashes($_REQUEST ["param"]);
		$data ["type"] = $_REQUEST ["type"];
		$data ["position"] = $_REQUEST ["position"];
		
		$wc ["layoutid"] = $data ["layoutid"];
		$wc ["position"] = $data ["position"];
		
		$widget = M ( "Widget" )->where ( $wc )->find ();
		if (empty ( $widget ) && ! empty ( $_REQUEST ["name"] )) {
			$data ["name"] = $_REQUEST ["name"];
			$widgetName = $_REQUEST ["name"];
			M ( "Widget" )->add ( $data );
		} else if(!empty ( $widget )){
			M ( "Widget" )->data ( $data )->where ( $wc )->save ();
			$widgetName = $widget ["name"];
		}else{
			$this->error("widget不存在！");
		}
		$result = M ( "Widget" )->where ( $wc )->find ();
		$content = W ( $widgetName, $result, true );
		echo $content;
		// $this->redirect ( "/Layout/edit/id/" . $data ["layoutid"] );
	}
	/**
	 * 修改widget，返回编辑页面
	 */
	public function toEditWidget() {
		$wc ["layoutid"] = $_REQUEST ["layoutid"];
		$wc ["position"] = $_REQUEST ["position"];
		$widget = M ( "Widget" )->where ( $wc )->find ();
		
		$class = $widget ["name"] . 'Widget';
		require_cache ( LIB_PATH . 'Widget/' . $class . '.class.php' );
		if (! class_exists ( $class )) {
			throw_exception ( L ( '_CLASS_NOT_EXIST_' ) . ':' . $class );
		}
		$widgetObj = Think::instance ( $class );
		$content = $widgetObj->edit ( $widget );
		$content .= "<input type='hidden' id='position' value='" . $data ["position"] . "'>";
		$content .= "<input type='hidden' id='wname' value='" . $widget ["name"] . "'>";
		echo $content;
	}
	/**
	 * 返回widget列表
	 */
	public function listWidget() {
		$allWidgets = C ( "WIDGET" );
		$widgets = $allWidgets ["menu"];
		exit ( json_encode ( $widgets ) );
	}
	/**
	 * 添加widget，返回编辑页面
	 */
	public function toAddWidget() {
		$class = $_REQUEST ["wname"] . 'Widget';
		require_cache ( LIB_PATH . 'Widget/' . $class . '.class.php' );
		if (! class_exists ( $class )) {
			throw_exception ( L ( '_CLASS_NOT_EXIST_' ) . ':' . $class );
		}
		$widgetObj = Think::instance ( $class );
		$content = $widgetObj->edit ();
		$content .= "<input type='hidden' id='position' value='" . $_REQUEST ["position"] . "'>";
		$content .= "<input type='hidden' id='wname' value='" . $_REQUEST ["wname"] . "'>";
		echo $content;
	}
	/**
	 * 删除当前布局微件
	 */
	public function deleteWidgetHtml() {
		$data ["layoutid"] = $_REQUEST ["layoutid"];
		$data ["type"] = $_REQUEST ["type"];
		$method = $_REQUEST ["method"];
		$data ["position"] = $_REQUEST ["position"];
		$widgetName = $_REQUEST ["wname"];
		$wc ["layoutid"] = $data ["layoutid"];
		$wc ["position"] = $data ["position"];
		M ( "Widget" )->where ( $wc )->delete ();
		exit ( json_encode () );
	}
	/**
	 * 生成缩略图
	 */
	public function getThumBnail() {
		import ( "@.common.Thumbnail" );
		$layoutid = $_REQUEST ["layoutid"];
		$siteLayout = M ( "Site_layout" )->where ( "id=" . $layoutid )->find ();
		$site = M ( "Site" )->where ( "id=" . $siteLayout ["siteid"] )->find ();
		$domain = $site ["domain"];
		$url = $domain . "/tacms/index.php?=/Index/";
		$fileName = "";
		Thumbnail::snapshot ( $url, $layoutid . ".jpg" );
	}
}
?>