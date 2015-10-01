{%extends "search/searchaladdin/c_base/iphone.tpl"%}

{%block name="data_modifier"%}
    {%$tplData._alaFm="alwz"%}
    {%$tplData.showLeftText = "开发平台"%}
    {%$tplData.showRightUrl = "http://www.baidu.com/"%}
    {%$tplData.showRightText = "查看更多相关结果"%}
    {%$tplData.url="http://m.baidu.com"%}
    {%$tplData.title="我的标题文案"%}
    {%$tplData.len = 8 %}
	{%$tplData.hook = array()%}
	{%$tplData.list = array( array("","",""),array("",""),array("","",""))%}
{%/block%}

{%block name="content"%}{%strip%}
<style>
.wa-gcw-scroll-wrapper{
	overflow: hidden;
	position: relative;
}
.wa-gcw-scrollor{
	width: {%$tplData.len * 100|cat:"%" %};
}
.wa-gcw-scrollor li{
	width: {%(1 / $tplData.len)*100|cat:"%" %};
	height: 300px;
	display: inline-block;
}
.wa-gcw-scrollor li:nth-of-type(1) {
  background-color: red;
}
.wa-gcw-scrollor li:nth-of-type(2) {
  background-color: blue;
}
.wa-gcw-scrollor li:nth-of-type(3) {
  background-color: yellow;
}
</style>
	<div class="c-tabs c-gap-top wa-gcw-tabs">
		<div class="c-row-tile">
			<ul class="c-tabs-nav">
				<li class="c-tabs-nav-li c-tabs-nav-selected WA_LOG_TAB" data-tid="0">第一季
				</li><li class="c-tabs-nav-li WA_LOG_TAB" data-tid="1">第二季
				</li><li class="c-tabs-nav-li WA_LOG_TAB" data-tid="2">第三季
				</li>
			</ul>
		</div>
	</div>

	<div class="c-row-tile c-scroll-wrapper wa-gcw-scroll-wrapper">
		<ul class="wa-gcw-scrollor">
			{%$tplData.index = 0%}
			{%foreach $tplData.list as $item%}
				{%foreach $item as $item2%}
					{%if $item2@index == 0%}
						{%$tplData.hook[$tplData.index] = $item@index%}	
					{%/if%}		

					{%$tplData.index = $tplData.index  + 1%}
					<li class="wa-gcw-entity">佛挡杀佛惊呆了附近的老师看见</li>
				{%/foreach%}	
			{%/foreach%}
		</ul>
	</div>

	<div class="c-scroll-indicator wa-gcw-scroll-indicator">
		<span class="c-scroll-dotty-now"></span><span></span><span></span>
	</div>

<script>
A.setup({
	len : 5,
	hook: {%$tplData.hook|json_encode%}
});
</script>
    
<script data-merge>
A.init(function(){

var ct = $(this.container),self = this;

require(['uiamd/iscroll/iscroll'], function (IScroll){
	var gcwScroll = new IScroll('.wa-gcw-scroll-wrapper', {
		disableMouse     : true,
		scrollX          : true,
		scrollY          : false,
		eventPassthrough : true,
		scrollbars       : false,
		snap             : true
	});

	gcwScroll.on('scrollEnd', function(){
		var thisPage = this.currentPage.pageX;
		var tabindex = self.data.hook[thisPage] + "";
		if( tabindex != "undefined" && tabindex !== ""){
			console.log(thisPage);
			ct.find('.wa-gcw-tabs li').removeClass('c-tabs-nav-selected').eq(tabindex).addClass('c-tabs-nav-selected');
		}
		$('.wa-gcw-scroll-indicator span').removeClass('c-scroll-dotty-now').eq(thisPage).addClass('c-scroll-dotty-now');
	});

	var	lis = ct.find('.wa-gcw-tabs li').on("click",function(){
		$(this).addClass('c-tabs-nav-selected').siblings().removeClass('c-tabs-nav-selected');
		for(var key in self.data.hook){
			if(self.data.hook[key] == $(this).index()){
				gcwScroll.goToPage(key,0,800);
			}
		}
 	}); 

	$('body').one('onlyshowMore', function () {
		setTimeout(function() {
			gcwScroll.refresh();
		}, 0);
	});
});
});

</script>
{%/strip%}{%/block%}

