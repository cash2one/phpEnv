{%extends "search/searchaladdin/c_base/iphone.tpl"%}

{%block name="data_modifier"%}
    {%$tplData.showLeftText = $tplData.source%}
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
					<img data-imagedelaysrc="{%Utils_Common::timgUrl($tplData.img,8,100)%}">
					<div class="wa-livetv-text">
						<span class="c-icon" style="margin:0 5px;position: relative;top:-1px;">&#xe622</span>{%$tplData.imgtext%}
					</div>
				</div>
		</div>
	</div>
{%fe_fn_c_box_adaptive_suffix url=$tplData.url%}

<div class="c-row c-gap-top-large c-gap-bottom-small">
	<div class="c-span7 c-color-gray">
		<p><span>{%$tplData.level.textLeft%} : </span><span> {%$tplData.level.rightText%}</span></p>
		<p><span>时间 : </span><span> {%$tplData.time.from%}</span>—<span>{%$tplData.time.to%}</span></p>

	</div>
	<div class="c-span5 c-gap-top-small">
		{%fe_fn_c_box_adaptive_prefix url=$tplData.url class="c-blocka c-btn" %}
			{%$tplData.btnText%}
		{%fe_fn_c_box_adaptive_suffix url=$tplData.url %}
	</div>
</div>

<script data-merge>
A.init(function(){


});

</script>
{%/strip%}{%/block%}

