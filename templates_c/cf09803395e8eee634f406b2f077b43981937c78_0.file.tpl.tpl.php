<?php /* Smarty version 3.1.27, created on 2015-10-27 10:40:43
         compiled from "/Users/alan/htdocs/air/templates/core/tpl.tpl" */ ?>
<?php
/*%%SmartyHeaderCode:806328413562ee42ba6c765_57163270%%*/
if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'cf09803395e8eee634f406b2f077b43981937c78' => 
    array (
      0 => '/Users/alan/htdocs/air/templates/core/tpl.tpl',
      1 => 1445913629,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '806328413562ee42ba6c765_57163270',
  'variables' => 
  array (
    'onlyshow' => 0,
    'datas' => 0,
    'item' => 0,
    'tplName' => 0,
    'url' => 0,
  ),
  'has_nocache_code' => false,
  'version' => '3.1.27',
  'unifunc' => 'content_562ee42bac5864_28516711',
),false);
/*/%%SmartyHeaderCode%%*/
if ($_valid && !is_callable('content_562ee42bac5864_28516711')) {
function content_562ee42bac5864_28516711 ($_smarty_tpl) {

$_smarty_tpl->properties['nocache_hash'] = '806328413562ee42ba6c765_57163270';
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
		#code{
			position: absolute;
			right:0; 
		}
		.towweima{
			position: relative;
			height:50px;
		}
		.base{
			display:none;
		}
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
　　　　　　},
			urlArgs: {
				'uiamd/iscroll': 'v=1.0'
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
<div id="page" <?php if ($_smarty_tpl->tpl_vars['onlyshow']->value) {?> class="onlyshow" <?php }?> >



<?php if ($_smarty_tpl->tpl_vars['onlyshow']->value) {?>
	<?php echo $_smarty_tpl->getSubTemplate ("core/onlyshow.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0);
?>

	<style>
	.onlyshow .result:nth-of-type(2){
		min-height:602px; padding-top:91px !important; padding-bottom:43px !important;
	}
	#code{
		display:none;	
	}
	.towweima{
		height:0;
	}
	</style>
<?php }?>

	<div id="page-bd">
		<div id="results" >

			
			<div class="towweima">
				<div id="code"></div>
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
				<?php if (!$_smarty_tpl->tpl_vars['onlyshow']->value) {?>
					<div> <?php echo $_smarty_tpl->tpl_vars['item']->value['describe'];?>
 </div>
				<?php }?>

				
				<pre style="display:none;"> <?php echo print_r($_smarty_tpl->tpl_vars['item']->value['data']);?>
	</pre>

				
				<?php if ($_smarty_tpl->tpl_vars['onlyshow']->value) {?>
					<?php ob_start();
echo ($_smarty_tpl->tpl_vars['tplName']->value).("/iphone.only.tpl");
$_tmp1=ob_get_clean();
echo $_smarty_tpl->getSubTemplate ($_tmp1, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array('tplData'=>$_smarty_tpl->tpl_vars['item']->value['data']), 0);
?>

				<?php } else { ?>
					<?php ob_start();
echo ($_smarty_tpl->tpl_vars['tplName']->value).("/iphone.tpl");
$_tmp2=ob_get_clean();
echo $_smarty_tpl->getSubTemplate ($_tmp2, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array('tplData'=>$_smarty_tpl->tpl_vars['item']->value['data']), 0);
?>

				<?php }?>
			<?php
$_smarty_tpl->tpl_vars['item'] = $foreach_item_Sav;
}
?>
		</div>
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
	$('.result').first().append('<div id="onlyshow-bar" class="skin-light"><section></section><div class="bar"><div class="bar-l"><span>百度智能聚合</span></div><div class="bar-r"><span class="btn-fb"><i class="sicon-fb"></i>反馈</span><span class="slipt">|</span><span class="btn-share"><i class="sicon-share"></i>分享</span></div></div></div>');
    
<?php echo '</script'; ?>
>



</body></html>
<?php }
}
?>