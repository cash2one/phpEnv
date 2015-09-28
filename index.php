<?php 
include "init.php";

$config = json_decode(file_get_contents(tplDir . "/config.json"));//读取配置文件
//加载数据
foreach($config->data as $item){
	if($item->url){
		$datas[] = array(
			"data" => Utils_Tools::xml_to_array($item->url)
		);
	}
	$path = tplDir . "/" . $item->filename;
	if( file_exists($path)){
		$datas[] = array(
			"data" => Utils_Tools::xml_to_array(tplDir . "/" . $item->filename)['item']['display'],
			"describe" => $item->describe		
		);
	}else{
		$datas[] = array(
						
		);
	}
}

//assign variable
$smarty->assign("tplName",tplName);
$smarty->assign("datas",$datas);
$smarty->assign("tplDir",tplDir);
$smarty->display("core/tpl.tpl");


?>
