{%extends "search/searchaladdin/c_base/iphone.tpl"%}

{%block name="data_modifier"%}
    {%$tplData.showLeftText = "开发平台"%}
    {%$tplData.showRightUrl = "http://www.baidu.com/"%}
    {%$tplData.showRightText = "查看更多相关结果"%}
    {%$tplData.url="http://m.baidu.com"%}
    {%$tplData.title="Hellow World"%}
{%/block%}

{%block name="content"%}{%strip%}
<style>
</style>

content

<script data-merge>
A.init(function(){
	alert('afds');
	
});

</script>
{%/strip%}{%/block%}

