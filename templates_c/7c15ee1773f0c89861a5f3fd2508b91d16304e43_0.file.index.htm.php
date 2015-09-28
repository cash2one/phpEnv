<?php /* Smarty version 3.1.28-dev/54, created on 2015-09-04 03:40:16
         compiled from "/Users/alan/htdocs/air/templates/base/index.htm" */ ?>
<?php
/*%%SmartyHeaderCode:22173834355e912a0065de3_02144464%%*/
$_valid = $_smarty_tpl->decodeProperties(array (
  'has_nocache_code' => false,
  'version' => '3.1.28-dev/54',
  'unifunc' => 'content_55e912a0098df0_49881829',
  'file_dependency' => 
  array (
    '7c15ee1773f0c89861a5f3fd2508b91d16304e43' => 
    array (
      0 => '/Users/alan/htdocs/air/templates/base/index.htm',
      1 => 1441337988,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
  'isChild' => false,
),false);
/*/%%SmartyHeaderCode%%*/
if ($_valid && !is_callable('content_55e912a0098df0_49881829')) {
function content_55e912a0098df0_49881829 ($_smarty_tpl) {
$_smarty_tpl->compiled->nocache_hash = '22173834355e912a0065de3_02144464';
?>
<!DOCTYPE html>
<!-- saved from url=(0052)http://fedev.baidu.com/~yangfan16/grid/gridwiki.html -->
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="referrer" content="always">


    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <title>Grid for Wise</title>
    <link rel="stylesheet" href="http://fedev.baidu.com/~yangfan16/grid/less/iconfont.css">
    <link rel="stylesheet" href="http://fedev.baidu.com/~yangfan16/grid/less/frame.css">
    <link rel="stylesheet" href="http://fedev.baidu.com/~yangfan16/grid/less/grid.css">
    <style type="text/css">
		html,body{
			height:100%;	
		}
        /*细节*/
        #page-bd {
            max-width: 1000px;
            margin: 0 auto;
			height:100%;
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
 type="text/javascript" src="http://fedev.baidu.com/~yangfan16/grid/js/zepto.js"><?php echo '</script'; ?>
> 
   <?php echo '<script'; ?>
 type="text/javascript" src="http://fedev.baidu.com/~yangfan16/grid/js/esl.js"><?php echo '</script'; ?>
>
    <!-- 使用ESL加载器并完成配置 -->
    <?php echo '<script'; ?>
 type="text/javascript">
        require.config({
            //baseUrl: 'http://m.baidu.com/static/ala/',
            paths: {
                'uiamd': 'http://fedev.baidu.com/~yangfan16/grid/js/uiamd/'
　　　　　　},
            urlArgs: {
                'uiamd/iscroll': 'v=1.0'
            }
        });
    <?php echo '</script'; ?>
>
    <!-- 使用ESL加载器并完成配置 -->
	</head>
<body>

<div id="page-bd">
    <div id="results">
		<?php
$_from = $_smarty_tpl->tpl_vars['datas']->value;
if (!is_array($_from) && !is_object($_from)) {
settype($_from, 'array');
}
$__foreach_item_0_saved_item = isset($_smarty_tpl->tpl_vars['item']) ? $_smarty_tpl->tpl_vars['item'] : false;
$_smarty_tpl->tpl_vars['item'] = new Smarty_Variable();
$__foreach_item_0_total = $_smarty_tpl->_count($_from);
if ($__foreach_item_0_total) {
foreach ($_from as $_smarty_tpl->tpl_vars['item']->value) {
$__foreach_item_0_saved_local_item = $_smarty_tpl->tpl_vars['item'];
?>
			<div class="">
				<?php echo $_smarty_tpl->tpl_vars['item']->value['describe'];?>

			</div>
			<?php ob_start();
echo ($_smarty_tpl->tpl_vars['tplName']->value).("/iphone.tpl");
$_tmp1=ob_get_clean();?><?php $_smarty_tpl->_Subtemplate->renderSubtemplate($_smarty_tpl, $_tmp1, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array('tplData'=>$_smarty_tpl->tpl_vars['item']->value['data']), 0, true, true, false);
?>

		<?php
$_smarty_tpl->tpl_vars['item'] = $__foreach_item_0_saved_local_item;
}
}
if ($__foreach_item_0_saved_item) {
$_smarty_tpl->tpl_vars['item'] = $__foreach_item_0_saved_item;
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
    
<?php echo '</script'; ?>
>


</body></html>
<?php }
}
?>