{%extends "search/searchaladdin/c_base/iphone.tpl"%}

{%block name="data_modifier"%}
    {%$tplData.showLeftText = {%$tplData.from%}%}
    {%$tplData.showRightUrl = {%$tplData.site%}%}
	{%if !$tplData.abs[0]%}
		{%$tplData.abs = [{%$tplData.abs%}]%}
	{%/if%}
{%/block%}

{%block name="content"%}{%strip%}
<style>
.wa-shortvideo-scroll-wrapper{
	overflow: hidden;
	position: relative;
}
.wa-shortvideo-scrollor{
	padding:0 9px 0 15px;
}
.wa-shortvideo-scrollor li{
	vertical-align:  top;
	position: relative;
	display: inline-block;
	padding-right: 6px;
}

{%* 计算每个scroll的宽度 *%}
{%foreach $tplData.tabs as $item%}

	{%if !$item.play[0]%}
		{%$tplData.tabs[$item@index].play = [$item.play]%}
		{%$tplData.tabs[$item@index].play_num_baidu=1%}
		{%$item=$tplData.tabs[$item@index]%}
	{%/if%}

	.wa-shortvideo-pnth-{%$item@index%}{
		width:	{%fe_fn_c_img_scroll_pwrate col=4 num=$item.play_num_baidu|cat:"px"%};
	}
	.wa-shortvideo-pnth-{%$item@index%} li{
		width: {%100/$item.play_num_baidu|cat:"%"%}
	}
{%/foreach%}

.wa-shortvideo-43{
	padding-bottom:75%;
	height:0;
}
.wa-shortvideo-info{
	display: inline-block;
	margin-right:5px;
}

.wa-shortvideo-play{
	position: absolute;
	top:0px;
	left:5px;
}
.wa-shortvideo-mark{
	background-color:rgba(0,0,0,0.6);
	width:100%;
	text-align: right;
	color:#fff;
	position: absolute;
	left:0;
	bottom:0;
}
.wa-shortvideo-wrapper-scroll .c-tabs-nav .c-tabs-nav-selected{
	border-bottom:1px solid #38f;
}
</style>
	
	<div class="c-tabs  c-gap-top wa-shortvideo-wrapper-scroll">
		<div class="c-row-tile">
			<div class="c-tabs-nav-view">
				<ul class="c-tabs-nav">
					{%foreach $tplData.tabs as $item%}
						<li class="c-tabs-nav-li WA_LOG_TAB"> {%$item.title%} </li>
					{%/foreach%}
				</ul>
			</div>
		</div>

		{%foreach $tplData.tabs as $item%}
			<div class="c-tabs-content"  style=" {%if !$item@first%}  display: none; {%/if%}">
				<div class="c-gap-top  c-row-tile c-scroll-wrapper wa-shortvideo-scroll-wrapper ">
							<ul class="wa-shortvideo-scrollor wa-shortvideo-pnth-{%$item@index%}">
								{%foreach $item.play as $item2%}
									<li>
										{%fe_fn_c_box_adaptive_prefix url= {%$item2.url%} class="c-blocka" %}
											<div style="position: relative">
												<div class="c-img wa-shortvideo-43">
													<img src="{%Utils_Common::timgUrl({%$item2.img%},8,60)%}">
												</div>
												<div class="wa-shortvideo-mark">
													<span class="c-icon wa-shortvideo-play">&#xe735</span>
													<span class="wa-shortvideo-info"> {%$item2.time%} </span>
	
												</div>
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
    
<script data-merge>
A.init(function(){

var $ct = $(this.container);

require(['uiamd/tabs/tabs'], function (Tabs){
		var scrollTabs = new Tabs($ct.find('.wa-shortvideo-wrapper-scroll'), {
			allowScroll: true,
			toggleMore: false,
			onChange:function(){
				sols[this.current].refresh();
			}
		});
});	
var sols = [];

require(['uiamd/iscroll/iscroll'], function (IScroll){
	var scrolls = [].slice.call(document.querySelectorAll(".wa-shortvideo-scroll-wrapper"));

	scrolls.forEach(function(el,index){
		var shortvideoScroll = new IScroll(el, {
			disableMouse: true,
			scrollX: true,
			scrollY: false,
			eventPassthrough : true,
			scrollbars: false
		});

		sols.push(shortvideoScroll);
	});

	$('body').one('onlyshowMore', function () {
		setTimeout(function() {
			sols.forEach(function(el,index){
				el.refresh();		
			});
		}, 0);
	});

});




});

</script>
{%/strip%}{%/block%}

