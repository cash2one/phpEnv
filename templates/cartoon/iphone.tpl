{%extends "search/searchaladdin/c_base/iphone.tpl"%}

{%block name="data_modifier"%}
{%if $tplData.result && !$tplData.result[0]%}
	{%$tplData.result = [$tplData.result]%}
{%/if%}
{%$r1 = $tplData.result[0]%}

{%$tplData.title = $r1.show_name|cat:$r1.title_suf%}

{%/block%}

{%block name="title"%}
	{%*tab切换title,预飘红*%}
	{%foreach $tplData.result as $item%}
		{%fe_fn_c_box_adaptive_prefix url=$item.url ltj="title" class="c-blocka {%if !$item@first%} wa-cartoon-hide {%/if%} wa-cartoon-title-{%$item@index%}"%}
		<h3 class="c-title c-gap-top-small">{%fe_fn_c_text_inline text=$item.title highlight='' %}</h3>
		{%fe_fn_c_box_adaptive_suffix url=$item.url%}
	{%/foreach%}
{%/block%}

{%block name="content"%}{%strip%}
<style>
	.wa-cartoon-hide{
		display:none;
	}
	{%foreach $tplData.result as $item%}
		.wa-cartoon-scroller-{%$item@index%} {
			white-space: nowrap;
			width:{%fe_fn_c_img_scroll_pwrate col=3 num=$item.ep_info_num_baidu%};
		}

		.wa-cartoon-scroller-{%$item@index%} li{
			position: relative;
			display: inline-block;
			vertical-align: top;
			width:{%100/$item.ep_info_num_baidu|cat:'%'%};
		}

	{%/foreach%}

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

	.wa-cartoon-mark{
		position: absolute;
		top:0;
		left:0;
		background-color:rgba(0,0,0,0.6);
		color:#fff;
		width:100%;
		height:100%;
		text-align: center;
		-webkit-align-items: center; -webkit-box-align: center; align-items: center;
		-webkit-justify-content:center;
	}
</style>

	<div class="c-tabs c-gap-top wa-tabs-wrapper-scroll">
		{%foreach $tplData.result as $item%}
			<div class="c-tabs-content" {%if !$item@first %} style="display:none;" {%/if%}>
				<div class="c-row-tile c-gap-top-small c-scroll-wrapper wa-cartoon-scroll-wrapper c-gap-bottom">
					{%if $item.ep_info && !$item.ep_info[0]%}
						{%$item.ep_info = [$item.ep_info]%}
						{%$item.ep_info_num_baidu = 1%}
					{%/if%}
					<ul class="wa-cartoon-scroller wa-cartoon-scroller-{%$item@index%} c-scroll-parent-gap">
						{%foreach $item.ep_info as $item2%}
							<li class="c-scroll-element-gap wa-cartoon-entity">
                                {%*查看更多跳转title链接*%}
                                {%$show_len = 10%}
                                {%if $item2@last && $item.ep_info_num_baidu > $show_len %}
                                    {%$r_url = $item.url%}
                                {%else%}
                                    {%$r_url = $item2.linkurl%}
                                {%/if%}
								{%fe_fn_c_box_adaptive_prefix url=$r_url ltj='l' class="c-blocka"%}
									<div class="c-img">
                                        <img src="{%$item2.picurl|getHttpsHost%}" />
									</div>
                                    {%*大于10条出现查看更多*%}
									{%if $item2@last && $item.ep_info_num_baidu > $show_len %}
										<div class="wa-cartoon-mark c-flexbox" >
                                            <div style="-webkit-box-flex:1;">
                                                <div style="font-size:40px;">
                                                    <img width="40%" src="{%"http://t10.baidu.com/it/u=289035567,2501947275&amp;fm=58"|getHttpsHost%}">
                                                </div>
                                                <div style="font-size:12px;margin-top:5px">查看更多</div>
                                            </div>
										</div>
									{%else%}
										<p class="wa-cartoon-scroll-text c-line-clamp1">{%$item2.text|escape%}</p>
										{%if $item2.is_new && $item2.is_new =='1'%}
											<i class="c-text c-text-danger">新</i>
										{%/if%}
									{%/if%}
								{%fe_fn_c_box_adaptive_suffix url=$item2.linkurl%}
							</li>
						{%/foreach%}
					</ul>
				</div>
				{%*
				<div class="c-row c-gap-bottom-large">
					<div class="c-span12">
						{%fe_fn_c_box_adaptive_prefix url=url class="c-btn" %}
							继续阅读12话
						{%fe_fn_c_box_adaptive_suffix url=url %}
					</div>
				</div>
				*%}
			</div>
		{%/foreach%}

		<div class="c-row-tile c-row-bottom">
			<div class="c-tabs-nav-view">
				<ul class="c-tabs-nav c-tabs-nav-bottom">
					{%foreach $tplData.result as $item%}
						<li style="-webkit-tap-highlight-color: transparent;" class="c-tabs-nav-li WA_LOG_TAB {%if $item@first%} c-tabs-nav-selected {%/if%}" data-tid="0"><img style="position: relative;width:16px;top:2px;margin-right:5px;" src="{%$item.site_logo|getHttpsHost%}"/>{%$item.site_name|escape%}</li>
					{%/foreach%}	
				</ul>
			</div>
		</div>
	</div>

<script data-merge>
A.init(function(){
	var scrollTabs,
		$ct = $(this.container),
		scrolls = [];
	
	require(['uiamd/tabs/tabs'], function (Tabs){
		scrollTabs = new Tabs($('.wa-tabs-wrapper-scroll'), {
            allowScroll: true,
            toggleMore: false,
			onChange:function(){
				scrolls[this.current].refresh();
				$ct.find('.wa-cartoon-title-' + this.current).show().siblings("a").hide();
			}
        });
    });

	require(['uiamd/iscroll/bdscroll'], function (IScroll){
		[].slice.call(document.querySelectorAll('.wa-cartoon-scroll-wrapper')).forEach(function(el,index){
			var Scroll = new IScroll(el, {
				disableMouse: true,
				scrollX: true,
				scrollY: false,
				eventPassthrough : true,
				scrollbars: false
			});
			scrolls.push(Scroll);
		});

		$('body').one('onlyshowMore', function () {
			setTimeout(function() {
				scrolls.forEach(function(el,index){
					el.refresh();
				});
			}, 0);
		});
	});

		

	
			

});
	

</script>
{%/strip%}{%/block%}

