{%extends "search/searchaladdin/c_base/iphone.tpl"%}

{%block name="data_modifier"%}
	{%$alaData = Utils_Common::arr2utf8($alaData)%}
	{%$r1 = $alaData.resultData.tplData.Result[0].Display[0]["data"]%}
	{%$tplData.title = $r1.title%}
	{%$alaData.hilightstr = iconv('utf-8', 'gbk', $alaData.strategy.hilightWord )%}
	{%$tplData.url = $r1.url%}
{%/block%}


{%block name="content"%}{%strip%}
<style>
.wa-livetv-text{
	position: absolute;
	background-color:rgba(0,0,0,0.6);
	height:30px;
	line-height:30px;
	left:0;
	width:100%;
	bottom:0;
	color:#fff;
}
.wa-livetv-img .c-img{
	height:0;
	position: relative;
	padding-bottom:{%318/1116*100|cat:"%"%};
	margin:0;
}

</style>

{%fe_fn_c_box_adaptive_prefix url=$tplData.url class="c-blocka" %}
	<div class="c-row c-gap-top">
		<div class="c-span12 wa-livetv-img">
				<div class="c-img">
					<img data-imagedelaysrc="{%Utils_Common::timgUrl($r1.img,8,100)%}">
					<div class="wa-livetv-text">
						<span class="c-icon" style="margin:0 5px;position: relative;top:-1px;">&#xe622</span>{%$r1.imgtext%}
					</div>
				</div>
		</div>
	</div>
{%fe_fn_c_box_adaptive_suffix url=$r1.url%}

<div class="c-row c-gap-top-large c-gap-bottom-small">
	<div class="c-span7 c-color-gray">
		<p><span>{%$r1.level.textLeft%} : </span><span> {%$r1.level.rightText%}</span></p>
		<p><span>时间 : </span><span> {%$r1.time.from%}</span>—<span>{%$r1.time.to%}</span></p>

	</div>
	<div class="c-span5 c-gap-top-small">
		{%fe_fn_c_box_adaptive_prefix url=$r1.url class="c-blocka c-btn" %}
			{%$r1.btnText%}
		{%fe_fn_c_box_adaptive_suffix url=$r1.url %}
	</div>
</div>

<script data-merge>
A.init(function(){


});

</script>
{%/strip%}{%/block%}

