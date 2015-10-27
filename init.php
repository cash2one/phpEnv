<?php
define("basepath",$_SERVER['DOCUMENT_ROOT'] . "/air/");
define("tplName",$_GET['q']);//q=模板名召回
define("onlyshow",$_GET['o']);//q=唯一答案
define("tplDir", basepath . "templates/" . tplName);

require_once( basepath . "libs/Smarty.class.php");
date_default_timezone_set("PRC");

$smarty = new Smarty();
//config
$smarty->caching = false;
$smarty->left_delimiter = "{%"; 
$smarty->right_delimiter = "%}"; 

?>
