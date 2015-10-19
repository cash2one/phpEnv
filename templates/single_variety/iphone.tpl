{%extends "search/searchaladdin/c_base/iphone.tpl"%}

{%block name="data_modifier"%}
		
	{%if !$tplData.result[0]%}
		$tplData.result = [ $tplData.result];
	{%/if%}

	{%$tplData.wrapWidth = "{%fe_fn_c_img_scroll_pwrate col=4 num=5%}"%}
	{%$tplData.childWidth = "{%100/5|cat:"%"%}"%}

	{%if !$tplData.queryparser[0]%}
		{%$tplData.queryparser = [$tplData.queryparser]%}
	{%/if%}
	
	{%if $tplData.queryparser[0].guests%}
		{%foreach $tplData.queryparser as $item%}
			{%$guest=$guest|cat:$item.guests%}
		{%/foreach%}
	
		{%$title=$tplData.result[0].title|cat:$guest|cat:"_相关视频"%}
	{%else%}
		{%if $tplData.resNum ==1%}
			{%$title=$tplData.result[0].title|cat:$tplData.result.showdate|cat:"_相关视频"%}
		{%else%}
				{%$title=$tplData.result[0].title|cat:"_相关视频"%}
		{%/if%}
	{%/if%}

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
	font-size:13px;
	background-color: rgba(0,0,0,0.5);
	text-align:right;
}

.wa-single-variety-info span{
	display:inline-block;
	position:relative;
	top:1px;
	margin-right:5px;
}
.wa-single-variety-info c-icon{
	top:2px;
	font-size:18px;
}
.wa-single-variety-scroll-wrapper .c-img{
	margin: 0;	
	border-top:0;
	height:0;
	border-bottom:0;
	position:relative;
	padding-bottom:75%;
}

</style>

{%if $tplData.resNum == 1%}
	{%$tplData = $tplData.result[0]%}
	{%if !$tplData.videoPlay[0]%}
		{%$tplData.videoPlay = [$tplData.videoPlay] %}
	{%/if%}

	<div class="c-tabs c-gap-top wa-single-variety-wrap">
			{%foreach $tplData.videoPlay as $item%}
                <div class="c-tabs-content" {%if !$item@first%} style="display: none;"{%/if%} >
					{%fe_fn_c_box_adaptive_prefix url=$item._attr.link ltj="title" class="c-blocka"%}
						<h3 class="c-title c-gap-top-small">{%fe_fn_c_text_inline text=$title highlight='' %}</h3>
					{%fe_fn_c_box_adaptive_suffix url=$item._attr.link%}

					<div class="c-row c-gap-top-small">
						<div class="c-span3">
						{%fe_fn_c_box_adaptive_prefix url=$item._attr.link  class="c-blocka"%}
							{%fe_fn_c_img_delay type="l" imgsrc={%$tplData.poster%}%}
						{%fe_fn_c_box_adaptive_suffix url=$item._attr.link%}
						</div>
						<div class="c-span9">
							<p class="c-line-clamp1"><span>日期：</span><span>{%$tplData.playdate%}</span></p>
							<p class="c-line-clamp1"><span>{%$tplData.content1._attr.name%}：</span><span>{%implode('、',explode(' ',$tplData.content1._attr.dtl))%}</span></p>
							<p class="c-line-clamp1"><span>{%$tplData.content2._attr.name%}：</span><span>{%implode('、',explode(' ',$tplData.content2._attr.dtl))%}</span></p>
							<div class="c-row c-gap-top">
								<div class="c-span6">
									{%fe_fn_c_box_adaptive_prefix url={%$item._attr.link%} class="c-btn wa-single-variety-btn" %}
										<span class="c-icon">&#xe732</span>
										立即观看
									{%fe_fn_c_box_adaptive_suffix url={%$item._attr.link%} %}
								</div>
								<div class="c-span8"></div>
							</div>
						</div>
					</div>
				</div>
			{%/foreach%}

				<div class="c-gap-top-large c-row-tile WA_LOG_GES c-row-bottom">
                    <div class="c-tabs-nav-view">
                        <ul class="c-tabs-nav c-tabs-nav-bottom">
							{%foreach $tplData.videoPlay as $item%}
							<li class="c-tabs-nav-li WA_LOG_TAB {%if $item@first%} c-tabs-nav-selected {%/if%}" data-tid="1"><i class="c-tabs-nav-icon c-icon c-gap-right-small"><img style="vertical-align:middle;margin-right:5px;" src="{%Utils_Common::timgUrl($item._attr.icon, 8, 100)%}" /></i>{%$item._attr.name%}</li>
							{%/foreach%}
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
<h3 class="c-title c-gap-top-small">{%$title%}</h3>
	<div class="c-row-tile">
		<div class="c-gap-top c-scroll-wrapper WA_LOG_GES wa-single-variety-scroll-wrapper">
			<ul class="wa-single-variety-scrollor">
				{%foreach $tplData.result as $item%}
				<li>
					<div style="position: relative">
						
						{%fe_fn_c_box_adaptive_prefix url= {%$item.url%} class="c-blocka" %}
							<div class="c-img">
								<img src="{%Utils_Common::timgUrl($item.content_pic, 8, $size)%}"		
							</div>
						{%fe_fn_c_box_adaptive_suffix url= {%$item.url%} %}
						<div class="wa-single-variety-info-wrap">
							<div class="wa-single-variety-info"><span>{%$item.playdate%}</span></div>
							<span class="c-icon">&#xe735</span>
						</div>
					</div>
					<div style="text-align:center;" class="c-gap-top-small c-line-clamp2">
						{%fe_fn_c_box_adaptive_prefix url= {%$item.url%} class="c-blocka" %}
							{%implode('、',explode(' ',$item.content1._attr.dtl))%}
						{%fe_fn_c_box_adaptive_suffix url= {%$item.url%} %}
					</div>
				</li>
				{%/foreach%}
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




