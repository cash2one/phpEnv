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
   <script type="text/javascript" src="js/zepto.js"></script> 
   <script type="text/javascript" src="js/esl.js"></script>
   <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
   <script type="text/javascript" src="js/jquery.qrcode.min.js"></script>
    <!-- 使用ESL加载器并完成配置 -->
    <script type="text/javascript">
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
    
    </script>
    <!-- 使用ESL加载器并完成配置 -->
    <!-- 模拟全局js -->
	<script >
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
	</script>
	</head>
<body>
<div id="page" {%if $onlyshow%} class="onlyshow" {%/if%} >

{%$skin_light=1%}

{%*唯一答案样式*%}
{%if $onlyshow%}
	{%include file="core/onlyshow.tpl" %}
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

	{%if $skin_light%}
		#page-hd .cur{
			color:#fff;
			background:rgba(255,255,255,.1);
			border-top:2px solid rgba(255,255,255,.4);
		}
		#page-hd .logo{
			background-image:url(//m.baidu.com/static/search/resultlogo_white.png)!important;
		}
	{%/if%}
	</style>
{%/if%}

	<div id="page-bd">
		<div id="results" >

			{%*二维码*%}
			<div class="towweima">
				<div id="code"></div>
			</div>

			{%*结果*%}
			{%foreach $datas as $item%}
				{%if !$onlyshow%}
					<div> {%$item.describe%} </div>
				{%/if%}

				{%*打印数据*%}
				<pre style="display:none;"> {%$item.data|@print_r%}	</pre>

				{%*载入模板*%}
				{%if $onlyshow%}
					{%include file= {%$tplName|cat:"/iphone.only.tpl"%} tplData = $item.data  %}
				{%else%}
					{%include file= {%$tplName|cat:"/iphone.tpl"%} tplData = $item.data  %}
				{%/if%}
			{%/foreach%}
		</div>
	</div>
</div>

<script type="text/javascript">
	 $('img[data-imagedelaysrc]').each(function(){
        this.src = this.getAttribute('data-imagedelaysrc');
        this.removeAttribute('data-imagedelaysrc');
    });

	$('#code').qrcode({width: 64,height: 64,text: "{%$url%}"});
	
	//唯一答案底部
	{%if $onlyshow%}
		$('.result').first().append('<div id="onlyshow-bar" class="skin-light"><section></section><div class="bar"><div class="bar-l"><span>百度智能聚合</span></div><div class="bar-r"><span class="btn-fb"><i class="sicon-fb"></i>反馈</span><span class="slipt">|</span><span class="btn-share"><i class="sicon-share"></i>分享</span></div></div></div>');
	{%/if%}
    
</script>



</body></html>
