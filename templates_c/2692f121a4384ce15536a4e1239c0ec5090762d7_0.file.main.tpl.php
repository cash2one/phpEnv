<?php /* Smarty version 3.1.28-dev/54, created on 2015-09-11 18:03:34
         compiled from "/Users/alan/htdocs/air/templates/core/main.tpl" */ ?>
<?php
/*%%SmartyHeaderCode:22449264855f2a6f6528e26_27243679%%*/
$_valid = $_smarty_tpl->decodeProperties(array (
  'has_nocache_code' => false,
  'version' => '3.1.28-dev/54',
  'unifunc' => 'content_55f2a6f6554198_38629011',
  'file_dependency' => 
  array (
    '2692f121a4384ce15536a4e1239c0ec5090762d7' => 
    array (
      0 => '/Users/alan/htdocs/air/templates/core/main.tpl',
      1 => 1441965811,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
  'isChild' => false,
),false);
/*/%%SmartyHeaderCode%%*/
if ($_valid && !is_callable('content_55f2a6f6554198_38629011')) {
function content_55f2a6f6554198_38629011 ($_smarty_tpl) {
$_smarty_tpl->compiled->nocache_hash = '22449264855f2a6f6528e26_27243679';
?>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title></title>

	<frameset cols="30%,40%,30%">
		<frame src="http://tc-mbu-web13.epc.baidu.com:8003?tn=iphone">
		<frame src="tpl.php?q=<?php echo tplName;?>
">
		<frame src="templates/<?php echo $_smarty_tpl->tpl_vars['tplName']->value;?>
/test.txt">
	</frameset>
</head>
</html>
<?php }
}
?>