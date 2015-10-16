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

	{%$tplData.wrapWidth = "{%fe_fn_c_img_scroll_pwrate col=5 num=5%}"%}
	{%$tplData.childWidth = "{%100/5|cat:"%"%}"%}
{%/block%}

{%block name="content"%}{%strip%}
<style>
.wa-gcw-scroll-wrapper{
	overflow: hidden;
	position: relative;
}
.wa-gcw-scrollor{
	width: {%$tplData.wrapWidth%};
	padding:0 9px 0 15px;
}
.wa-gcw-scrollor li{
	width:	{%$tplData.childWidth%};
	vertical-align:  top;
	position: relative;
	display: inline-block;
	padding-right: 6px;
}

.wa-gcw-play{
	width:50px;
	height:50px;
	position: absolute;
	top:50%;
	left:50%;
	margin-top:-25px;
	margin-left:-25px;
	border-radius:50%;
	background-color:rgba(0,0,0,0.3);
}

.wa-gcw-play .c-icon{
	font-size:60px;
	line-height:50px;
	color:#fff;
	position: relative;
	left:-5px;
	top:-1px;
}
</style>
	
	<div class="c-tabs c-gap-top wa-gcw-wrapper-scroll">
		<div class="c-row-tile">
			<ul class="c-tabs-nav">
				<li class="c-tabs-nav-li WA_LOG_TAB c-tabs-nav-selected" data-tid="0">第一季
				</li><li class="c-tabs-nav-li WA_LOG_TAB" data-tid="1">第二季
				</li><li class="c-tabs-nav-li WA_LOG_TAB" data-tid="2">第三季 </li>
				</li>
			</ul>
		</div>
		<div class="c-tabs-content">
			<div class="c-gap-top  c-row-tile c-scroll-wrapper wa-gcw-scroll-wrapper">
						<ul class="wa-gcw-scrollor">
							<li>
								<div style="position: relative">
									{%fe_fn_c_img_delay imgsrc={%$tplData.url%} %}
									<span class="wa-gcw-play">
										<span class="c-icon">&#xe735</span>
									</span>
								</div>
								<div class="c-gap-top-small c-line-clamp2">
									{%fe_fn_c_box_adaptive_prefix url= 'fds' class="c-blocka" %}
										发的发的顺丰的付费方式范德萨范德萨范德萨	
									{%fe_fn_c_box_adaptive_suffix url= 'fds' %}
								</div>
							</li>
							<li>
								{%fe_fn_c_img_delay imgsrc={%$tplData.url%} %}
							</li>
							<li>
								{%fe_fn_c_img_delay imgsrc={%$tplData.url%} %}
							</li>
							<li>
								{%fe_fn_c_img_delay imgsrc={%$tplData.url%} %}
							</li>
							<li>
								{%fe_fn_c_img_delay imgsrc={%$tplData.url%} %}
							</li>
						</ul>
					</div>	
		</div>
		<div class="c-tabs-content" style="display: none;">第二季内容</div>
		<div class="c-tabs-content" style="display: none;">第三季内容</div>
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
		disableMouse: true,
		scrollX: true,
		scrollY: false,
		eventPassthrough : true,
		scrollbars: false
	});


	$('body').one('onlyshowMore', function () {
		setTimeout(function() {
			gcwScroll.refresh();
		}, 0);
	});
});


require(['uiamd/tabs/tabs'], function (Tabs){
		var scrollTabs = new Tabs($('.wa-gcw-wrapper-scroll'), {
			allowScroll: true,
			toggleMore: false
		});
});	

});

</script>
{%/strip%}{%/block%}

