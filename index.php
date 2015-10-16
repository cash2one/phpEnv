<?php 
include "init.php";

//smarty依赖
require_once( basepath . "env/SmartMain.php");
require_once( basepath . "env/utils_air.php");
require_once( basepath . "env/utils_common.php");
require_once( basepath . "env/utils_file.php");
require_once( basepath . "env/utils_wise.php");


function send_post($url, $post_data) {
  
  $options = array(
  'http' => array(
  'method' => 'POST',//or GET
  'header' => 'Content-type:application/x-www-form-urlencoded',
  'content' => $post_data,
  'timeout' => 15 * 60 // 超时时间（单位:s）
  )
  );
  $context = stream_context_create($options);
  $result = file_get_contents($url, false, $context);
  return $result;
 }

$urlpref = "--uri=(dsp%3Diphone)&--RetFormat=json&--SpReqType=&--UriKey=&--EntityName=&--ClientName=us&--key=&--OpenGssdaRecall=0&--isec=0&--pro=&--city=&--isp=&--hilight=&--subclass=0&--PageNum=0&--ResNum=10&--tagfilter=&-H=&--qtrans=&--appinfoarr=&--cookie=&--region_name=cn&--lang_name=SIMP_CHINESE&-n=1&--ctpl_or_php=1&--tbi=&delfields=NowTime&--uname=&--uid=&--Sid=&isvui=on&vuiaddress=10.48.23.102%3A8080&method=getpfmres&isvui=1&vuiip=10.48.23.102:8080";



//读取配置文件
$config = json_decode(file_get_contents(tplDir . "/config.json"));
//加载数据
foreach($config->data as $item){
	//从open平台读取
	if($item->url){
		$datas[] = array(
			"data" => Utils_Tools::xml_to_array($item->url),
			"describe" => $item->describe		
		);
	}else if($item->gssurl){
		$parm = http_build_query((array)$item->gssurl) . $urlpref;
		$result=send_post('http://cq01-testing-ps11127.vm.baidu.com:8090/handle/pfmtesthandle.php',$parm);	
		$aa = json_decode($result)->pfmtest_json;
		$aa = preg_replace("/\(uint32\)/m","",$aa);
		$aa = preg_replace("/\(uint64\)/m","",$aa);
		$aa = preg_replace("/\(int32\)/m","",$aa);
		$aa = preg_replace("/\(int64\)/m","",$aa);
		$aa = preg_replace("/\(raw\).*/m","\"RAWDATA\",",$aa);
		$aa = preg_replace("/@/m","_",$aa);
		$bb = (array)json_decode($aa)->Result[0]->Display;

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

//传递变量
$smarty->assign("tplName",tplName);
$smarty->assign("datas",$datas);
$smarty->assign("tplDir",tplDir);
$smarty->display("core/tpl.tpl");


?>
