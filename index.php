<?php 
include "init.php";

//smarty依赖
require_once( basepath . "env/SmartMain.php");
require_once( basepath . "env/utils_air.php");
require_once( basepath . "env/utils_common.php");
require_once( basepath . "env/utils_file.php");
require_once( basepath . "env/utils_wise.php");



//递归函数,不要放到静态函数里面
 function objectToArray($e){
	$e=(array)$e;
	foreach($e as $k=>$v){
		if( gettype($v)=='resource' ) return;
		if( gettype($v)=='object' || gettype($v)=='array' )
			$e[$k]=(array)objectToArray($v);
	}
	return $e;
 }



$urlpref = "&--uri=&--RetFormat=json&--SpReqType=&--UriKey=&--EntityName=&--ClientName=us&--key=&--OpenGssdaRecall=0&--isec=0&--pro=&--city=&--isp=&--hilight=&--subclass=0&--PageNum=0&--ResNum=10&--tagfilter=&-H=&--qtrans=&--appinfoarr=&--cookie=&--region_name=cn&--lang_name=SIMP_CHINESE&-n=1&--ctpl_or_php=1&--tbi=&delfields=NowTime&--uname=&--uid=&--Sid=&isvui=on&vuiaddress=10.48.23.102%3A8080&method=getpfmres&isvui=1&vuiip=10.48.23.102:8080";


//读取配置文件
$config = json_decode(file_get_contents(tplDir . "/config.json"));
//加载数据
foreach($config->data as $item){
	//从open平台读取
	if($item->kvurl){
		$keys = array("format"=>"xml","tn"=>"wisetpl");
		$keys = http_build_query(array_merge($keys,(array)$item->kvurl));
		$url = "http://opendata.baidu.com/api.php?".$keys;
		$datas[] = array(
			"data" => Utils_Tools::xml_to_array($url)["data"],
			"describe" => $item->describe		
		);
	}else if($item->gssurl){
		$parm = http_build_query((array)$item->gssurl) . $urlpref;
		$result = Utils_Tools::send_post('http://cp01-ernan-1.epc:8090/handle/pfmtesthandle.php',$parm);	
		$aa = json_decode($result)->pfmtest_json;
		$aa = preg_replace("/\(uint32\)/m","",$aa);
		$aa = preg_replace("/\(uint64\)/m","",$aa);
		$aa = preg_replace("/\(int32\)/m","",$aa);
		$aa = preg_replace("/\(int64\)/m","",$aa);
		$aa = preg_replace("/\(raw\).*/m","\"RAWDATA\",",$aa);
		$aa = preg_replace("/@/m","_",$aa);
		$bb = objectToArray(json_decode($aa)->Result[0]->Display);

		$datas[] = array(
			"data" => $bb,
			"describe" => $item->describe		
		);
			
	} else{
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

$output = shell_exec("ifconfig");
preg_match('/en0:[\s\S]*?([0-9\.]*?) netmask/', $output, $arr);

//传递变量
$smarty->assign("tplName",tplName);
$smarty->assign("datas",$datas);
$smarty->assign("tplDir",tplDir);
$smarty->assign("url",'http://'. $arr[1] .':'.$_SERVER["SERVER_PORT"].$_SERVER["REQUEST_URI"]);
$smarty->display("core/tpl.tpl");


?>
