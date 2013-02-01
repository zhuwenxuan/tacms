<?php 
/**
 * 该类主要用于系统常用公共方法
 * @author ace
 *
 */
class TacmsUtil{
	//public $temp = array (); // 栏目有序列表
	//public $tempIndex = array (); // 数据库中无序栏目列表
	/**
	 * 栏目排序方法
	 */
	public function doManageCategory() {
		$list = D ( 'category' )->order('listorder+0 asc')->select (); // 从数据库读取全部数据
	
		foreach ( $list as $key => $value ) {//按照-字符来进行空格的分割
			$size = count ( explode ( '-', $value ['arrparentid'] ) );
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
			if ($this->tempIndex[$key] ['parentid'] == $flag) {
				$result = false;
				break;
			}
		}
		return $result;
	}
	/**
	 * 栏目排序方法
	 */
	public function doOrderCategory($flag) {
		foreach ( $this->tempIndex as $key => $value ) {
			if ($this->tempIndex [$key] ['parentid'] == $flag) {
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
	
	
	
}

?>