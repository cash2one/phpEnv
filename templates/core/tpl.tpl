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
   <script type="text/javascript" src="http://fedev.baidu.com/~yangfan16/grid/js/zepto.js"></script> 
   <script type="text/javascript" src="http://fedev.baidu.com/~yangfan16/grid/js/esl.js"></script>
    <!-- 使用ESL加载器并完成配置 -->
    <script type="text/javascript">
        require.config({
            //baseUrl: 'http://m.baidu.com/static/ala/',
            paths: {
                'uiamd': 'http://fedev.baidu.com/~yangfan16/grid/js/uiamd/'
　　　　　　},
            urlArgs: {
                'uiamd/iscroll': 'v=1.0'
            }
        });
    </script>
    <!-- 使用ESL加载器并完成配置 -->
	</head>
<body>

<div id="page-bd">
    <div id="results">
			{%include file= "search/searchaladdin/c_base/iphone.tpl" tplData = $item.data  %}
		{%foreach $datas as $item%}
			<div class="">
				{%$item.describe%}
			</div>
			<pre style="display:none;">
				{%$item.data|@print_r%}	
			</pre>
			{%include file= {%$tplName|cat:"/iphone.tpl"%} tplData = $item.data  %}
		{%/foreach%}
    </div>
</div>

<script type="text/javascript">
    $('img[data-imagedelaysrc]').each(function(){
        this.src = this.getAttribute('data-imagedelaysrc');
        this.removeAttribute('data-imagedelaysrc');
    });
    
</script>


</body></html>
