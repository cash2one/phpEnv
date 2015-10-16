{%extends "search/searchaladdin/c_base/iphone.tpl"%}

{%block name="data_modifier"%}
	{%$tplData = $tplData.result[0]%}
    {%$tplData.showLeftText = "开发平台"%}
    {%$tplData.showRightUrl = "http://www.baidu.com/"%}
    {%$tplData.showRightText = "查看更多相关结果"%}
    {%$tplData.url="http://m.baidu.com"%}
    {%$tplData.len = 8 %}
	{%$tplData.hook = array()%}
	{%$tplData.list = array( array("","",""),array("",""),array("","",""))%}

	{%$tplData.type = 2%}
	{%$tplData.wrapWidth = "{%fe_fn_c_img_scroll_pwrate col=5 num=5%}"%}
	{%$tplData.childWidth = "{%100/5|cat:"%"%}"%}
{%/block%}

{%block name="title"%}
{%/block%}

{%block name="foot"%}
{%/block%}

{%block name="content"%}{%strip%}
<style>
.wa-single-variety-wrap{

}
.wa-single-variety-btn{
}
.wa-single-variety-btn .c-icon{
	position: relative;
	top:  -2px;
	color: #02aaf8;
	margin-left: 0;
}
.wa-single-variety-scroll-wrapper{
	overflow: hidden;
	position: relative;
}
.wa-single-variety-scrollor{
	width: {%$tplData.wrapWidth%};
	padding:0 9px 0 15px;
}
.wa-single-variety-scrollor li{
	width:	{%$tplData.childWidth%};
	vertical-align:  top;
	position: relative;
	display: inline-block;
	padding-right: 6px;
}
.wa-single-variety-info-wrap{
	position: absolute;
	width:100%;
	bottom:0;
	left:0;
	color:#fff;
}

.wa-single-variety-info-wrap .c-icon{
	position:  absolute;
	left: 5px;
	top:0;
}
.wa-single-variety-info{
	background-color: rgba(0,0,0,0.5);
	text-align:center;
}
.wa-single-variety-scroll-wrapper .c-img{
	margin: 0;	
	border-top:0;
	border-bottom:0;
}

</style>

{%if $tplData.type ==1%}
	{%fe_fn_c_box_adaptive_prefix url=$tplData.url ltj="title" class="c-blocka"%}
	{%fe_fn_c_title%}
	{%fe_fn_c_box_adaptive_suffix url=$tplData.url%}

	<div class="c-row">
		<div class="c-span3">
			{%fe_fn_c_img_delay imgsrc={%$tplData.imgurl%}%}
		</div>
		<div class="c-span9">
			<p class="c-line-clamp1"><span>日期：</span><span>123</span></p>
			<p class="c-line-clamp1"><span>主题：</span><span>123</span></p>
			<p class="c-line-clamp1"><span>嘉宾：</span><span>123</span></p>
			<div class="c-row c-gap-top">
				<div class="c-span6">
					<a href="" class="c-btn wa-single-variety-btn">
						<span class="c-icon">&#xe732</span>
						立即观看
					</a>
				</div>
				<div class="c-span5"></div>
			</div>
		</div>
	</div>
	<div class="c-tabs c-gap-top wa-single-variety-wrap">
                <div class="c-tabs-content" style="display: none;">百度音乐</div>
                <div class="c-tabs-content">QQ音乐</div>
                <div class="c-tabs-content" style="display: none;">虾米音乐</div>
                <div class="c-tabs-content" style="display: none;">听音乐</div>
                <div class="c-tabs-content" style="display: none;">网易云音乐</div>
					<div class="c-row-tile c-row-bottom">
                    <div class="c-tabs-nav-view">
                        <ul class="c-tabs-nav c-tabs-nav-bottom">
                            <li class="c-tabs-nav-li WA_LOG_TAB" data-tid="0"><i class="c-tabs-nav-icon wa-tabs-card-icon-baidu c-gap-right-small"></i>百度音乐
                            </li><li class="c-tabs-nav-li WA_LOG_TAB c-tabs-nav-selected" data-tid="1"><i class="c-tabs-nav-icon c-icon c-gap-right-small"></i>QQ音乐
                            </li><li class="c-tabs-nav-li WA_LOG_TAB" data-tid="2"><i class="c-tabs-nav-icon c-icon c-gap-right-small"></i>虾米音乐
                            </li><li class="c-tabs-nav-li WA_LOG_TAB" data-tid="3"><i class="c-tabs-nav-icon c-icon c-gap-right-small"></i>听音乐
                            </li><li class="c-tabs-nav-li WA_LOG_TAB" data-tid="4"><i class="c-tabs-nav-icon c-icon c-gap-right-small"></i>网易云音乐
                            </li><li class="c-tabs-nav-li WA_LOG_TAB" data-tid="4"><i class="c-tabs-nav-icon c-icon c-gap-right-small"></i>网易云音乐
                            </li><li class="c-tabs-nav-li WA_LOG_TAB" data-tid="4"><i class="c-tabs-nav-icon c-icon c-gap-right-small"></i>网易云音乐
                            </li><li class="c-tabs-nav-li WA_LOG_TAB" data-tid="4"><i class="c-tabs-nav-icon c-icon c-gap-right-small"></i>网易云音乐
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
	<script data-merge>
		A.init(function(){
			require(['uiamd/tabs/tabs'], function (Tabs){
				var fixedTabs = new Tabs($('.wa-single-variety-wrap'), {
					allowScroll: true
				});
			});
		});
	
	</script>
{%else%}
	<h3 class="c-title c-gap-top-small"> {%$tplData.title%} </h3>
	<div class="c-row-tile">
		<div class="c-gap-top c-scroll-wrapper wa-single-variety-scroll-wrapper">
			<ul class="wa-single-variety-scrollor">
				<li>
					<div style="position: relative">
						{%fe_fn_c_img_delay imgsrc={%$tplData.url%} type="w"%}
						<div class="wa-single-variety-info-wrap">
							<div class="wa-single-variety-info">哈哈哈</div>
							<span class="c-icon">&#xe731</span>
						</div>
					</div>
					<div class="c-gap-top-small c-line-clamp2">
						{%fe_fn_c_box_adaptive_prefix url= 'fds' class="c-blocka" %}
							发的发的顺丰的付费方式范德萨范德萨范德萨	
						{%fe_fn_c_box_adaptive_suffix url= 'fds' %}
					</div>
				</li>
				<li>
					{%fe_fn_c_img_delay imgsrc={%$tplData.url%} type="w"%}
				</li>
				<li>
					{%fe_fn_c_img_delay imgsrc={%$tplData.url%} type="w"%}
				</li>
				<li>
					{%fe_fn_c_img_delay imgsrc={%$tplData.url%} type="w"%}
				</li>
				<li>
					{%fe_fn_c_img_delay imgsrc={%$tplData.url%} type="w"%}
				</li>
			</ul>
		</div>
	</div>
	<script data-merge>
	A.init(function(){
           require(['uiamd/iscroll/iscroll'], function (IScroll){
           	var varietyScroll = new IScroll('.wa-single-variety-scroll-wrapper', {
           		disableMouse: true,
           		scrollX: true,
           		scrollY: false,
           		eventPassthrough : true,
           		scrollbars: false
           	});

           	$('body').one('onlyshowMore', function () {
           		setTimeout(function() {
           			varietyScroll.refresh();
           		}, 0);
           	});
           }); 
		
	});
</script>
	
{%/if%}
    
{%/strip%}{%/block%}


