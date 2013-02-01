<?php
// 配置类型模型
class MemberModel extends CommonModel {
	protected $_validate = array(
		array('name','require','名称必须'),
		);

	protected $_auto		=	array(
        array('status',1,self::MODEL_INSERT,'string'),
		array('create_time','time',self::MODEL_INSERT,'function'),
		array('update_time','time',self::MODEL_UPDATE,'function'),
		);
}
?>