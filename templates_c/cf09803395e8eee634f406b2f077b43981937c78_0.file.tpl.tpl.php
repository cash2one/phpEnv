<?php /* Smarty version 3.1.27, created on 2015-10-21 18:45:46
         compiled from "/Users/alan/htdocs/air/templates/core/tpl.tpl" */ ?>
<?php
/*%%SmartyHeaderCode:93357642156276cdad6ccc6_58885223%%*/
if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'cf09803395e8eee634f406b2f077b43981937c78' => 
    array (
      0 => '/Users/alan/htdocs/air/templates/core/tpl.tpl',
      1 => 1445402781,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '93357642156276cdad6ccc6_58885223',
  'variables' => 
  array (
    'item' => 0,
    'datas' => 0,
    'tplName' => 0,
    'url' => 0,
  ),
  'has_nocache_code' => false,
  'version' => '3.1.27',
  'unifunc' => 'content_56276cdada33b8_08814813',
),false);
/*/%%SmartyHeaderCode%%*/
if ($_valid && !is_callable('content_56276cdada33b8_08814813')) {
function content_56276cdada33b8_08814813 ($_smarty_tpl) {

$_smarty_tpl->properties['nocache_hash'] = '93357642156276cdad6ccc6_58885223';
?>
<!DOCTYPE html>
<!-- saved from url=(0052)http://fedev.baidu.com/~yangfan16/grid/gridwiki.html -->
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="referrer" content="always">
	<base href="templates/core/"/>
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <title>Grid for Wise</title>
	<link rel="stylesheet" href="http://fedev.baidu.com/~yangfan16/grid/less/iconfont.css">
    <link rel="stylesheet" href="http://fedev.baidu.com/~yangfan16/grid/less/frame.css">
    <link rel="stylesheet" href="http://fedev.baidu.com/~yangfan16/grid/less/grid.css">

<!--
	<link rel="stylesheet" href="css/iconfont.css">
    <link rel="stylesheet" href="css/frame.css">
    <link rel="stylesheet" href="css/grid.css">
-->
    <style type="text/css">
		html,body{
			height:100%;	
		}
        /*细节*/
        #page-bd {
            max-width: 1000px;
            margin: 0 auto;
        }
        .wa-col-main {
            min-height: 50px;
            background-color: #ffcccc;
        }
        #results > p {
            font-size: 13px;
        }
        body {
            font: 14px;
            line-height: 1.65;
            background-color: #333;
        }
        h4 {
            background: #84a1c1;
            color: #fff;
            padding-left: 5px;
            font-size: 18px;
        }
        code {
            background:#FFEBB3;
        }
        .code {
            width: 100%;
            height: 100px;
        }
        /*
        .c-blocka:active:before{
            content: '';
            display: block;
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: 99;
            background: rgba(143, 155, 211, 0.46);
        }
        */
    </style>
   <?php echo '<script'; ?>
 type="text/javascript" src="js/zepto.js"><?php echo '</script'; ?>
> 
   <?php echo '<script'; ?>
 type="text/javascript" src="js/esl.js"><?php echo '</script'; ?>
>
   <?php echo '<script'; ?>
 src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"><?php echo '</script'; ?>
>
   <?php echo '<script'; ?>
 type="text/javascript" src="js/jquery.qrcode.min.js"><?php echo '</script'; ?>
>
    <!-- 使用ESL加载器并完成配置 -->
    <?php echo '<script'; ?>
 type="text/javascript">
        require.config({
            //baseUrl: 'http://m.baidu.com/static/ala/',
            paths: {
                //'uiamd': 'http://ws.baidu.com/content/wiki/grid/gridwiki/js/uiamd/'
                'uiamd': '//m.baidu.com/static/ala/uiamd/'
　　　　　　}
        });
    
    <?php echo '</script'; ?>
>
    <!-- 使用ESL加载器并完成配置 -->
    <!-- 模拟全局js -->
	<?php echo '<script'; ?>
 >
		window.A = {
			data : null,
			setup: function(data){
				this.data = data;
			},
			init : function(func){
				var obj = {
					data : this.data,
					container:document
				};
				func.call(obj);
			}
		};
	<?php echo '</script'; ?>
>
	</head>
<body>

<div id="page-bd">
	<div id="results">
		<div style="height:50px;position: relative;">
			<div id="code" style="position: absolute;right:0;"></div>
			<hr/>
			<div class="base" style="display:none;">
				<?php echo $_smarty_tpl->getSubTemplate ("search/searchaladdin/c_base/iphone.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array('tplData'=>$_smarty_tpl->tpl_vars['item']->value['data']), 0);
?>

			</div>
		</div>
		<?php
$_from = $_smarty_tpl->tpl_vars['datas']->value;
if (!is_array($_from) && !is_object($_from)) {
settype($_from, 'array');
}
$_smarty_tpl->tpl_vars['item'] = new Smarty_Variable;
$_smarty_tpl->tpl_vars['item']->_loop = false;
foreach ($_from as $_smarty_tpl->tpl_vars['item']->value) {
$_smarty_tpl->tpl_vars['item']->_loop = true;
$foreach_item_Sav = $_smarty_tpl->tpl_vars['item'];
?>
			<div class="">
				<?php echo $_smarty_tpl->tpl_vars['item']->value['describe'];?>

			</div>
			<pre style="display:none;">
				<?php echo print_r($_smarty_tpl->tpl_vars['item']->value['data']);?>
	
			</pre>
			<?php ob_start();
echo ($_smarty_tpl->tpl_vars['tplName']->value).("/iphone.tpl");
$_tmp1=ob_get_clean();
echo $_smarty_tpl->getSubTemplate ($_tmp1, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array('tplData'=>$_smarty_tpl->tpl_vars['item']->value['data']), 0);
?>

		<?php
$_smarty_tpl->tpl_vars['item'] = $foreach_item_Sav;
}
?>
    </div>
</div>

<?php echo '<script'; ?>
 type="text/javascript">
	 $('img[data-imagedelaysrc]').each(function(){
        this.src = this.getAttribute('data-imagedelaysrc');
        this.removeAttribute('data-imagedelaysrc');
    });

	$('#code').qrcode({width: 64,height: 64,text: "<?php echo $_smarty_tpl->tpl_vars['url']->value;?>
"});
    
<?php echo '</script'; ?>
>



</body></html>
<?php }
}
?>