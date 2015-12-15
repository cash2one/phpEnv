{%extends "search/searchaladdin/c_base/iphone.tpl"%}

{%block name="data_modifier"%}
{%if $tplData.result && !$tplData.result[0]%}
	{%$tplData.result = [$tplData.result]%}
{%/if%}
{%$r1 = $tplData.result[0]%}

{%$tplData.title = $r1.show_name|cat:$r1.title_suf%}

{%*默认站点的图片个数*%}
{%$defaultSite.imgsCount=$imgs[$defaultSite.sitePinyin]|count%}

{%$tplData.showLeftText = $defaultSite.siteName|cat:'漫画'%}
{%$tplData.showRightUrl = $defaultSite.moreUrl%}

{%/block%}

{%block name="content"%}{%strip%}
<style data-merge>
	.wa-cartoon-scroller {
		white-space: nowrap;
	}

	.wa-cartoon-scroller li {
		position: relative;
		display: inline-block;
		vertical-align: top;
	}

	.wa-cartoon-scroller a {
		position: relative;	
		}

	.wa-cartoon-scroll-text {
		position: absolute;
		bottom: 0;
		left: 0;

		width: 100%;
		height: 16.666666666666668px;
		margin-bottom: 0;

		font-size: 14px;
		line-height: 16px;
		text-align: center;

		color: #fff;
		background-color: rgba(0,0,0,0.5);
	}

	.wa-cartoon-entity .c-text-danger {
		position: absolute;
		top: 0;
		right: 0;
	}
	.wa-cartoon-entity .c-img{
		height: 0; 
		overflow: hidden;
		margin: 0;
		padding-bottom: 133.33333333333333%;  
	}
</style>

	<div class="c-tabs c-gap-top wa-tabs-wrapper-scroll">
		{%foreach $tplData.result as $item%}
			<div class="c-tabs-content">
				<div class="c-row-tile c-gap-top-small c-scroll-wrapper wa-cartoon-scroll-wrapper c-gap-bottom">
					<ul class="wa-cartoon-scroller c-scroll-parent-gap" style="width:{%fe_fn_c_img_scroll_pwrate col=3 num=5%};">
						{%if $item.ep_info && !$item.ep_info[0]%}
							{%$item.ep_info = [$item.ep_info]%}
						{%/if%}
						{%foreach $item.ep_info as $item2%}
							<li class="c-scroll-element-gap wa-cartoon-entity" style="width:{%100/5|cat:'%'%}">
								{%fe_fn_c_box_adaptive_prefix url=$item2.linkurl ltj='l' class="c-blocka"%}
									<div class="c-img">
										<img src="{%Utils_Common::timgUrl($item2.picurl)%}" />
									</div>
									<p class="wa-cartoon-scroll-text c-line-clamp1">{%$item2.text|escape%}</p>
									{%if $item.isNew && $item.isNew=='1'%}
										<i class="c-text c-text-danger">新</i>
									{%/if%}
								{%fe_fn_c_box_adaptive_suffix url=$item2.linkurl%}
							</li>
						{%/foreach%}
					</ul>
				</div>
				<div class="c-row c-gap-bottom-large">
					<div class="c-span12">
						{%fe_fn_c_box_adaptive_prefix url=url class="c-btn" %}
							继续阅读12话
						{%fe_fn_c_box_adaptive_suffix url=url %}
					</div>
				</div>
			</div>
		{%/foreach%}

		<div class="c-row-tile">
			<div class="c-tabs-nav-view">
				<ul class="c-tabs-nav c-tabs-nav-bottom">
					<li class="c-tabs-nav-li WA_LOG_TAB c-tabs-nav-selected" data-tid="0">第一季 </li>
					<li class="c-tabs-nav-li WA_LOG_TAB" data-tid="1">第二季 </li>
					<li class="c-tabs-nav-li WA_LOG_TAB" data-tid="1">第二季 </li>
					<li class="c-tabs-nav-li WA_LOG_TAB" data-tid="1">第二季 </li>
					<li class="c-tabs-nav-li WA_LOG_TAB" data-tid="1">第二季 </li>
					<li class="c-tabs-nav-li WA_LOG_TAB" data-tid="1">第二季 </li>
					<li class="c-tabs-nav-li WA_LOG_TAB" data-tid="1">第二季 </li>
				</ul>
			</div>
		</div>
	</div>
	
    

<script data-merge>
A.init(function(){

	require(['uiamd/tabs/tabs'], function (Tabs){
        var scrollTabs = new Tabs($('.wa-tabs-wrapper-scroll'), {
            allowScroll: true,
            toggleMore: false
        });
    });	

	require(['uiamd/iscroll/iscroll'], function (IScroll){
		var cartoonScroll = new IScroll('.wa-cartoon-scroll-wrapper', {
			disableMouse: true,
			scrollX: true,
			scrollY: false,
			eventPassthrough : true,
			scrollbars: false
		});

		$('body').one('onlyshowMore', function () {
			setTimeout(function() {
				cartoonScroll.refresh();
			}, 0);
		});
	});

		

	
			

});
	

</script>
{%/strip%}{%/block%}

