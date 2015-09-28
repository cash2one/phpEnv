
<?php 
include "init.php";

//define variable
$config = json_decode(file_get_contents(tplDir . "/config.json"));//读取配置文件


//加载数据
foreach($config->data as $item){
	$path = tplDir . "/" . $item->filename;
	if( file_exists($path)){
		$datas[] = array(
			"data" => Utils_Tools::xml_to_array(tplDir . "/" . $item->filename)['item']['display'],
			"describe" => $item->describe		
		);
	}else{
		echo $path . " 不存在";
	}
}

print_r($datas);
//assign variable
$smarty->assign("tplName",tplName);
$smarty->assign("datas",$datas);
$smarty->display("core/data.tpl");


?>
