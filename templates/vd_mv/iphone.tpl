{%extends "search/searchaladdin/c_base/iphone.tpl"%}

{%block name="data_modifier"%}
	{%if $tplData && !$tplData.result[0]%}
		{%$tplData.result = [$tplData.result]%}
	{%/if%} 
	{%$r1 = $tplData.result[0]%}
	{%$tplData.title = "电影"|cat:$r1.show_name%}

    {%*是否显示别名*%}
    {%if $r1.show_alias && (strpos($tplData.OriginQuery, $tplData.result[0].show_name) === false)%}
        {%if !$r1.show_alias[0]%}
            {%$r1.show_alias = [$r1.show_alias]%}
        {%/if%}
        {%$escaped_alias=""%}
        {%foreach $r1.show_alias as $item%}
            {%if strpos($tplData.OriginQuery, $item) !== false%}
                {%$escaped_alias = $item%}
                {%break%}
            {%/if%}
        {%/foreach%}

        {%if $escaped_alias != ""%}
            {%$tplData.title = $tplData.title|cat:"(又名:"|cat:$escaped_alias|cat:")"%}
        {%/if%}
    {%/if%}

{%/block%}

{%block name="title"%}
{%/block%}

{%block name="foot"%}
{%/block%}

{%block name="content"%}{%strip%}
<style>
.wa-vd-mv-btn {
	color:#fff;
	background-color:#0C77E5;
	border-color:#0C77E5;
	font-size:16px;
	width:auto;
}
.wa-vd-mv-btn .c-icon{
	position: relative;
	font-size:16px;
	top:  -2px;
	color: #fff;
	margin-left: 0;
}
.wa-vd-mv-info-wrap{
	position: absolute;
	width:100%;
	bottom:0;
	left:0;
	color:#fff;
}

.wa-vd-mv-info-wrap .c-icon{
	position:  absolute;
	left: 5px;
	top:0px;
}

.wa-vd-mv-info{
	font-size:13px;
	background-color: rgba(0,0,0,0.5);
	text-align:right;
}

.wa-vd-mv-info span{
	font-size:13px;
	display:inline-block;
	position:relative;
	top:1px;
	margin-right:5px;
}

.wa-vd-mv-info .c-icon{
	top:2px;
	font-size:18px;
}

</style>


	<div class="c-tabs c-gap-top wa-vd-mv-wrap">
			{%foreach $tplData.result as $item%}
                <div class="c-tabs-content" {%if !$item@first%} style="display: none;"{%/if%} >

					{%fe_fn_c_box_adaptive_prefix url=$item.videoPlay.link ltj="title" class="c-blocka"%}
						<h3 class="c-title c-gap-top-small">{%fe_fn_c_text_inline text=$tplData.title|escape highlight='' %}</h3>
					{%fe_fn_c_box_adaptive_suffix url=$item.videoPlay.link%}

					<div class="c-row c-gap-top-small">
						<div class="c-span4">
							{%fe_fn_c_box_adaptive_prefix url=$item.url  class="c-blocka"%}
								{%fe_fn_c_img_delay type="l" imgsrc={%$r1.poster%}%}
							{%fe_fn_c_box_adaptive_suffix url=$item.url%}
						</div>

						<div class="c-span8">
							{%if $r1.se_year%}
								<p class="c-abstract c-line-clamp1"><span>上映时间：</span><span>{%$r1.se_year|cat:"年"|escape%}</span></p>
							{%/if%}
							{%if $r1.se_type%}
								<p class="c-abstract c-line-clamp1"><span>类型：</span><span>{%implode(' / ',explode('$',$r1.se_type))|escape%}</span></p>
							{%/if%}
							{%if $r1.se_director%}
								<p class="c-abstract c-line-clamp1"><span>导演：</span><span>{%implode(' / ',explode('$',$r1.se_director))|escape%}</span></p>
							{%/if%}
							{%if $r1.se_actor%}
								<p class="c-abstract c-line-clamp1"><span>主演：</span><span>{%implode(' / ',explode('$',$r1.se_actor))|escape%}</span></p>
							{%/if%}
							
							<div class="c-gap-top">
                                    {%if $item.videoPlay.link%}
                                        {%fe_fn_c_box_adaptive_prefix url={%$item.videoPlay.link%} class="c-btn wa-vd-mv-btn" %}
                                            <span class="c-icon">&#xe732</span>
                                            {%if $item.btntext%} {%$item.btntext%}{%else%}立即观看{%/if%}
                                        {%fe_fn_c_box_adaptive_suffix url={%$item.videoPlay.link%} %}
                                    {%/if%}
							</div>

						</div>
					</div>
				</div>
			{%/foreach%}

				<div class="c-gap-top-large c-row-tile WA_LOG_GES c-row-bottom">
                    <div class="c-tabs-nav-view">
                        <ul class="c-tabs-nav c-tabs-nav-bottom">
							{%foreach $tplData.result as $item%}
							<li class="c-tabs-nav-li WA_LOG_TAB {%if $item@first%} c-tabs-nav-selected {%/if%}" data-tid="1"><i class="c-tabs-nav-icon c-icon c-gap-right-small"><img style="vertical-align:middle;margin-right:5px;" src="{%Utils_Common::timgUrl($item.site_logo, 8, 100)%}" /></i>{%$item.se_sitename|escape%}</li>
							{%/foreach%}
                        </ul>
                    </div>
                </div>
            </div>

<script data-merge>
A.init(function(){
	require(['uiamd/tabs/tabs'], function (Tabs){
		var fixedTabs = new Tabs($('.wa-vd-mv-wrap'), {
			allowScroll: true
		});
	});
});

</script>
{%/strip%}{%/block%}

