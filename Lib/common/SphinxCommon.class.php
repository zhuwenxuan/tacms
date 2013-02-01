<?php
import ( "@.common.Sphinxapi" );
class SphinxCommon{
	/**
	 * 初始化搜索连接
	 * @return SphinxClient
	 */
	private $cl;
	public function __construct(){
		
		$this->cl = new SphinxClient ();
		$this->cl->SetServer ( C("host"), C("port") );
		$this->cl->SetConnectTimeout ( C("timeout") );
		$this->cl->SetArrayResult ( C("arrayResult") );
		$this->cl->SetMatchMode ( C("matchMode") );
	}
	/**
	 * 全文检索方法
	 * @param unknown_type $index    索引名称例如：1.*  2.index1,index2.... 3.index1
	 * @param unknown_type $keyWords 搜索关键字
	 * @param unknown_type $start    分页开始位置
	 * @param unknown_type $limit    每页最大条数
	 * @param unknown_type $siteid    站点id
	 */
	public  function sphinxSearchPage($index,$keyWords,$start,$limit,$siteid){
		$this->init();
		$this->cl->SetLimits($start, $limit);
	//	$cl->SetFilter("delflag", array(1));//delflag 为1代表未删除
		$this->cl->SetFilter("csiteid", array($siteid));
		$res = $this->cl->Query ( $keyWords, $index);
		dump($res);
		return $res;
	}
	/**
	 * 全文检索方法
	 * @param unknown_type $index    索引名称例如：1.*  2.index1,index2.... 3.index1
	 * @param unknown_type $keyWords 搜索关键字
	 * @param unknown_type $siteid    站点id
	 */
	public function sphinxSearchCount($index,$keyWords,$siteid){
		
		$this->init();
		$this->cl->SetFilter("delflag", array(1));//delflag 为1代表未删除
		$this->cl->SetFilter("csiteid", array($siteid));
		$res = $this->cl->Query ( $keyWords, $index);
		return $res;
	}
	
	/**
	 * 更改主索引删除标示位为0
	 * @param unknown_type $index 主索引
	 * @param unknown_type $id 主索引中数据id
	 */
	public Static function sphinxRemove($index,$id){
		$cl = new SphinxClient ();
		$cl->SetServer ( '121.127.229.109', 9312 );
		$cl->SetConnectTimeout ( 45 );
		$cl->UpdateAttributes($index, array('delflag'), array($id=>array(0)));
	}
	
	
}

?>