<?php 
include "init.php";

//smarty依赖
require_once( basepath . "env/SmartMain.php");
require_once( basepath . "env/utils_air.php");
require_once( basepath . "env/utils_common.php");
require_once( basepath . "env/utils_file.php");
require_once( basepath . "env/utils_wise.php");

//读取配置文件
$config = json_decode(file_get_contents(tplDir . "/config.json"));
//加载数据
foreach($config->data as $item){
	//从open平台读取
	if($item->url){
		$datas[] = array(
			"data" => Utils_Tools::xml_to_array($item->url)
		);
	}else{
		//从文件中读取	
		$path = tplDir . "/" . $item->filename;
		if( file_exists($path)){
			$datas[] = array(
				"data" => Utils_Tools::xml_to_array(tplDir . "/" . $item->filename)['item']['display'],
				"describe" => $item->describe		
			);
		}else{
			//文件不存在，则数据为空数组
			$datas[] = array();
		}
	
	}
}

//$smarty->testInstall();

//传递变量
$smarty->assign("tplName",tplName);
$smarty->assign("datas",$datas);
$smarty->assign("tplDir",tplDir);
$smarty->display("core/tpl.tpl");


?>
