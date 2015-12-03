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

contentfs
<script class="tpl" type="text/html">
	<% for( var i = 0 ; i < data.length; i++ ) {  %> 
		<%=data[i].name%>  
	<% } %>

	<div class="fsdfs"></div>
	<span>哈哈</span>
	<img src="" />
</script>

<script data-merge>
A.init(function(){
	
var tplRender = function(data,tplStr){
	var str = tplStr.replace(/<%=(.*?)%>/g,"');p.push($1);p.push('")
			.replace(/<%/g,"');")
			.replace(/%>/g,"p.push('");
	str = "var p = [];p.push('" + str + "');return p.join('');" ;
	var fn =  new  Function("data",str);
	return fn(data);
};

var sstr = tplRender([
	{"name":"fdsf"},
	{"name":"xxxxx"}
],document.querySelector(".tpl").innerHTML);

console.log(sstr);
alert(sstr);

});

</script>
{%/strip%}{%/block%}

