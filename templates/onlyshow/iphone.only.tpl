{%extends "search/searchaladdin/c_base/iphone.tpl"%}
{%block name="data_modifier"%}
{%$tplData.isIphoneOnly="wa-lovesuicide-wrap"%}
{%/block%}


{%block name="title"%}
{%/block%}
	
{%block name="footer"%}
{%/block%}

{%block name="content"%}


<style>
        .wa-lovesuicide-wrap{
			background-color:#0096ff;
			color:#fff;
		}
		.wa-lovesuicide-td{
			border-right:1px solid rgba(255,255,255,0.5);
			border-bottom:1px solid rgba(255,255,255,0.5);
			padding-top:8px;
			padding-bottom:8px;
		}
		.wa-lovesuicide-tr{
			text-align:center;
		}
		.wa-lovesuicide-bdl{
			border-left:1px solid rgba(255,255,255,0.5);
			border-top:1px solid rgba(255,255,255,0.5);
			margin:15px 20px 0 20px;
			max-height:78px;
			overflow:hidden;
		}
		.wa-lovesuicide-bdl .c-row{
			margin:0;
			padding:0;
		}
		.wa-lovesuicide-bdl a{
			color:#FFF;	
		}
		.wa-lovesuicide-more{
			margin-top:-20px;
			text-align:center;
			letter-spacing:6px;
		}
		.wa-lovesuicide-c{
			margin:5px  auto 10px auto;
			width:100px;
			text-align:center;
			font-size:20px;
		}
		.wa-lovesuicide-slink{
			background-color:#4dbaff;
			padding:25px 0 10px 0;
		}
		.wa-lovesuicide-s-wrap{
			margin:0 20px;
			border:1px solid rgba(255,255,255,0.5);
			padding:20px 0;
			text-align:center;
		}
		.wa-lovesuicide-s-wrap p{
			margin-top:16px;
		}
		.wa-lovesuicide-s-wrap p:first-child{
			margin-top:0;
		}
		.wa-lovesuicide-s-wrap::after{
			display:inline-block;
			content:'';
			width:0;
			height:100%;
			vertical-align:middle;
		}
		.wa-lovesuicide-s-wrap2{
			display:inline-block;
			text-align:left;
			vertical-align:middle;
		}

		.wa-lovesuicide-s-t{
			font-weight:bold;
			
		}
		.wa-lovesuicide-s-lk{
			border-bottom:1px solid rgba(255,255,255,0.5);
			color:#fff;
		}

		.wa-lovesuicide-s-imgwrap{
			text-align:center;
			margin-top:-45px;
		}
		.wa-lovesuicide-img{
			position:relative;
			top:40px;
			background-color:#4dbaff;
			padding:0 3px
		}
		.wa-lovesuicide-man{
			position:relative;
			top:-4px;
		}
		.wa-lovesuicide-txr{
			text-align:right;
		}
		.wa-lovesuicide-b1,.wa-lovesuicide-b2{
			text-align:justify;
		}
		.wa-lovesuicide-b2{
			font-weight:bold;
		}
		.wa-lovesuicide-c2{
			position:relative;
			top:-16px
		}
		.wa-lovesuicide-imglist{
			margin-top:15px;
		}
		.wa-lovesuicide-imglist a{
			color:#fff;
			font-size:10px;
		}
		.wa-lovesuicide-imglist p{
			text-align:center;	
			margin-top:-2px;
			line-height:18px;
		}
		.wa-lovesuicide-imglist div{
			text-align:center;
		}
		.wa-lovesuicide-b4{
			background:url("{%$tplData.bgImg|getHttpsHost%}") no-repeat;
			background-size:contain;
			width:184px;
			height:34px;
			
		}
		.wa-lovesuicide-p24n{
			font-size:18px;
			font-weight:bold;
			line-height:34px;
			margin-left:10px;
			color:#fff;
		}
		.wa-lovesuicide-p24{
			vertical-align:middle;
			position:relative;
			top:-2px;
		}
		.wa-lovesuicide-b3{
			width:184px;
			text-align:center;
			font-size:13px;
			cursor:pointer;
		}
		.wa-lovesuicide-phone{
			display:inline-block;
			float:right;
			overflow:hidden;
			margin-right:5px;
		}

		.wa-lovesuicide-box{
			text-align:center;
		}
		.wa-lovesuicide-top,.wa-lovesuicide-man,.wa-lovesuicide-by{
			display:inline-block;
		}
		.wa-lovesuicide-man{
			
		}
		.wa-lovesuicide-by{
			vertical-align:top;
			margin-left:10px;
		}
</style>

fdsfsdf
	{%foreach $tplData.phoneList.item as $item%}
		{%if {%$item.place|strpos:$tplData.ExtendedLocation%} !== '' %} 
			{%assign var=phone value=$item.phone%}
			{%break%}
		{%/if%}
	{%/foreach%}
<div class="wa-lovesuicide-box">
<div class="wa-lovesuicide-top c-gap-top-large">
	<div class="wa-lovesuicide-man wa-lovesuicide-txr">
		<img width=100px class="wa-lovesuicide-man" src="{%$tplData.manImg|getHttpsHost%}" />	
	</div>
	<div class="wa-lovesuicide-by">
		<p class="wa-lovesuicide-b1"><img width="184px" src="{%$tplData.byImg|getHttpsHost%}"/></p>
		<p class="wa-lovesuicide-b3 c-gap-top-large">全国24小时免费心理咨询</p>
		<a href="tel:{%$phone|default:$tplData.phoneList.item[0].phone%}" class="c-blocka WA_LOG_BTN" >
		<p class="wa-lovesuicide-b4 c-gap-top-small">
			<img class="wa-lovesuicide-p24" width="24px" src="{%Utils_Common::timgUrl($tplData.phone24Img)%}"/>
			<span class="wa-lovesuicide-p24n" >
				{%$phone|default:$tplData.phoneList.item[0].phone%}
			</span>
		</a>
		</p>
	</div>
</div>
</div>

<div class="wa-lovesuicide-more">更多免费咨询</div>
	<div class="wa-lovesuicide-bdl">
		{%foreach $tplData.phoneList.item as $item%}
				{%if $item@iteration %2 == 1  %} 
					<div class="wa-lovesuicide-tr c-row">
				{%/if%}
				<div  class="wa-lovesuicide-td c-span6">
					<a class="WA_LOG_BTN"  href="tel:{%$item.phone%}">
						<span>{%$item.place%}</span><span>免费咨询</span><span class="c-icon wa-lovesuicide-phone">&#xe733</span>
					</a>
				</div>
				 {%if $item@iteration %2 == 0 %} 
					</div>
				 {%/if%}
		{%/foreach%}
	</div>

<div class="wa-lovesuicide-c WA_LOG_BTN">
		<div class="c-icon wa-lovesuicide-c1">
			<span>&#xe73c</span>	
		</div>
		<div class="c-icon wa-lovesuicide-c2">
			<span>&#xe73c</span>	
		</div>
</div>

<p class="wa-lovesuicide-s-imgwrap"><img class="wa-lovesuicide-img" width="20px" src="{%$tplData.groupImg%}"/></p>
<div class="wa-lovesuicide-slink">
	<div class="wa-lovesuicide-s-wrap">
		<div class="wa-lovesuicide-s-wrap2">
			{%foreach $tplData.list.item as $item%}
				<p>
					<span class="wa-lovesuicide-s-t">{%$item.textLeft%}</span>
					{%fe_fn_c_box_adaptive_prefix url={%$item.url%} class="" %}
						<span class="wa-lovesuicide-s-lk">{%$item.textRight%}</span>
					{%fe_fn_c_box_adaptive_suffix url={%$item.url%} %}
				</p>
			{%/foreach%}
		</div>
	</div>
	<div class="c-row c-gap-left c-gap-right wa-lovesuicide-imglist">
		{%foreach $tplData.slink.item as $item%}
			<div class="c-span3">
				{%fe_fn_c_box_adaptive_prefix url=$item.url class="c-blocka" %}
				<img width="65px" src="{%Utils_Common::timgUrl($item.imgUrl)%}" /> 
					<p>{%$item.text%}</p>
				{%fe_fn_c_box_adaptive_suffix url=$item.url %}
			</div>
		{%/foreach%}
	</div>
</div>

<script data=merge>
	A.init(function(){
		var ct = $(this.container),self = this;
		var flag = 1,bdl_height = ct.find(".wa-lovesuicide-bdl").height();
		var expand = ct.find('.wa-lovesuicide-c').on("click",function(){
				if(++flag % 2 == 0){
					ct.find('.wa-lovesuicide-c span').html("&#xe736");
					ct.find('.wa-lovesuicide-bdl').css({'max-height':'inherit' });
				}else{
					ct.find('.wa-lovesuicide-c span').html("&#xe73c");
					ct.find('.wa-lovesuicide-bdl').css({'max-height':'78px' });
				}
			});

	},true)
</script>

{%/block%}
