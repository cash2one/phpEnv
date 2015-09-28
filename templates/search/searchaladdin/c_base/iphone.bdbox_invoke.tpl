{%extends "search/searchaladdin/c_base/iphone.tpl"%}
{%* 模板主体框架 *%}
{%block name="main_container"%}
{%alaEngine%}
{%block name="card_prefix"%}{%/block%}
<div class="result c-container{%if $tplData.isIphoneOnly%} c-container-tile {%$tplData.isIphoneOnly%}{%/if%}" srcid="{%$alaData.resourceid%}" {%alaTplInfo%}>
		{%block name="title"%}
        {%fe_fn_c_box_adaptive_prefix url=$tplData.url ltj="title" class="c-blocka"%}
        {%fe_fn_c_title%}
        {%fe_fn_c_box_adaptive_suffix url=$tplData.url%}
        {%/block%}
        {%block name="content"%}{%/block%}
        {%block name="foot"%}
        <div class="c-row">
		    {%fe_fn_c_showUrl leftUrl=$tplData.showLeftUrl leftText=$tplData.showLeftText rightUrl=$tplData.showRightUrl rightText=$tplData.showRightText%}
		</div>
        {%/block%}

{%if (($resultDispData.sublink.is_main && $resultDispData.sublink.is_main==1) || $resultDispData.strategybits.OFFICIALPAGE_FLAG) && $templateConfig.prerender == "1"%}
<link rel="prerender" href="{%$tplData.url|escape%}" data-newtab="true">
{%/if%}
{%if $tplData.hints%}
{%fe_fn_c_recommend hints=$tplData.hints%}
{%/if%}
{%block name="bdboxInvokeDom"%}
{%if $reqData.tn=="zbios" && $tplData.xse.xBasicData %}
{%if $pageData.baiduboxapp.isAndroid || ( !$pageData.baiduboxapp.isAndroid && version_compare($pageData.baiduboxapp.bd_version, '5.2') > 0)%}
<div>	
    <script>
	    A.setup({
			xBasicData: '{%json_encode($tplData.xse.xBasicData)|escape:javascript%}',
			xConfigData: '{%json_encode($tplData.xse.xConfigData)|escape:javascript%}',
			xCancelUrl: '{%json_encode($tplData.xse.xCancelUrl)|escape:javascript%}'
		},false);
	</script>
	<script data-merge>
		A.init(function() {
			var _this = this;	require(['uiamd/bdboxinvoke/xsearchBdboxStart_v5','uiamd/bdboxinvoke/xsearchInvokerMgr_v4','uiamd/bdboxinvoke/xsearchMgr_v4','uiamd/bdboxinvoke/xsearchBdbox_v5'], function (xsearchBdboxStart, xsearchInvokerMgr_v2, xsearchMgr_v2, xsearchBdbox_v2){
				xsearchBdboxStart(_this.data.xBasicData, _this.data.xConfigData, _this.data.xCancelUrl, _this);
				xsearchInvokerMgr_v2();
				xsearchMgr_v2();
				xsearchBdbox_v2(_this);
			});
		});
	</script>
</div>
{%/if%}
{%/if%}
{%/block%}
</div>
{%block name="card_suffix"%}{%/block%}
{%/block%}
