{%extends "search/searchaladdin/c_base/iphone.tpl"%}

{%block name="data_modifier"%}
	{%$tplData = $tplData.data%}
    {%$tplData.showLeftText = {%$tplData.from%}%}
    {%$tplData.showRightUrl = {%$tplData.site%}%}
    {%$tplData.showRightText =  {%$tplData.moretext%}%}


	{%if !$tplData.abs[0]%}
		{%$tplData.abs = [{%$tplData.abs%}]%}
	{%/if%}
{%/block%}

{%block name="content"%}{%strip%}
<style>
.wa-gcw-scroll-wrapper{
	overflow: hidden;
	position: relative;
}
.wa-gcw-scrollor{
	padding:0 9px 0 15px;
}
.wa-gcw-scrollor li{
	vertical-align:  top;
	position: relative;
	display: inline-block;
	padding-right: 6px;
}

{%* 计算每个scroll的宽度 *%}
{%foreach $tplData.tabs as $item%}

{%$item.xxxx=111%}

{%if !$item.play[0]%}
	{%$tplData.tabs[$item@index].play = [$item.play]%}
	{%$tplData.tabs[$item@index].play_num_baidu=1%}
	{%$item=$tplData.tabs[$item@index]%}
{%/if%}

.wa-gcw-pnth-{%$item@index%}{
	width:	{%fe_fn_c_img_scroll_pwrate col=4 num=$item.play_num_baidu|cat:"px"%};
}
.wa-gcw-pnth-{%$item@index%} li{
	width: {%100/$item.play_num_baidu|cat:"%"%}
}
{%/foreach%}

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
				{%foreach $tplData.tabs as $item%}
					<li class="c-tabs-nav-li WA_LOG_TAB {%if $item@first%} c-tabs-nav-selected {%/if%}" data-tid="0"> {%$item.title%} </li>
				{%/foreach%}
			</ul>
		</div>

		{%foreach $tplData.tabs as $item%}
			<div class="c-tabs-content" style=" {%if !$item@first%} display: none; {%/if%}">
				<div class="c-gap-top  c-row-tile c-scroll-wrapper wa-gcw-scroll-wrapper">
							<ul class="wa-gcw-scrollor wa-gcw-pnth-{%$item@index%}">
								{%foreach $item.play as $item2%}
									<li>
										{%fe_fn_c_box_adaptive_prefix url= {%$item2.url%} class="c-blocka" %}
											<div style="position: relative">
												{%fe_fn_c_img_delay imgsrc={%$item2.img%} %}
												<span class="wa-gcw-play">
													<span class="c-icon">&#xe735</span>
												</span>
											</div>
											<div style="text-align:center;" class="c-gap-top-small c-line-clamp2">
													{%$item2.text%}
											</div>
										{%fe_fn_c_box_adaptive_suffix url= {%$item2.url%} %}
									</li>
								{%/foreach%}
							</ul>
						</div>	
			</div>
		{%/foreach%}
	</div>

	

<script>
A.setup({
	len : 5,
	hook: {%$tplData.hook|json_encode%}
});
</script>
    
<script data-merge>
A.init(function(){

require(['uiamd/iscroll/iscroll'], function (IScroll){
	var scrolls = document.querySelectorAll(".wa-gcw-scroll-wrapper");
	var sols = [];

	[].slice.call(scrolls).forEach(function(el,index){
		var gcwScroll = new IScroll(el, {
			disableMouse: true,
			scrollX: true,
			scrollY: false,
			eventPassthrough : true,
			scrollbars: false
		});
		
		sols.push(gcwScroll);
	});


	$('body').one('onlyshowMore', function () {
		setTimeout(function() {
			[].slice.call(sols).forEach(function(el,index){
				el.refresh();		
			});
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

