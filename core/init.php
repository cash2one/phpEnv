<?php
define("basepath",$_SERVER['DOCUMENT_ROOT'] . "/air/");
define("tplName",$_GET['q']);//q=模板名召回
define("tplDir", basepath . "templates/" . tplName);

require_once( basepath . "env/SmartMain.php");
require_once( basepath . "env/utils_air.php");
require_once( basepath . "env/utils_common.php");
require_once( basepath . "env/utils_file.php");
require_once( basepath . "env/utils_wise.php");
require_once( basepath . "libs/Smarty.class.php");
date_default_timezone_set("PRC");

$smarty = new Smarty();
//config
$smarty->template_dir = basepath."/templates";
$smarty->compile_dir = basepath."/templates_c";
$smarty->config_dir = basepath."/config";
$smarty->cache_dir = basepath."/air/cache" ;
$smarty->caching = false;
$smarty->left_delimiter = "{%"; 
$smarty->right_delimiter = "%}"; 

?>
