{%assign var="alaModuleStart" value=[] scope="root"%}
{%assign var="alaModuleEnd" value=[] scope="root"%}
{%assign var="alaModuleCSS" value=[] scope="root"%}
{%assign var="alaModuleJS" value=[] scope="root"%}

{%function name="alaEngine" key="" fm=""%}
{%if $fm%}
{%assign var="_alaFm" value=$fm scope="root"%}
{%elseif $tplData._alaFm%}
{%assign var="_alaFm" value=$tplData._alaFm scope="root"%}
{%else%}
{%assign var="_alaFm" value="alop" scope="root"%}
{%/if%}
{%assign var="alaKey" value=$key scope="root"%}
{%assign var="fe_var_tc_jump" value="{%$pageData.url.rsUrlAbs%}w={%$reqData.pn%}_{%$reqData.rn%}_{%$reqData.word|urlencode%}/baiduid={%$reqData.baiduid|urlencode%}/t={%$pageData.abct%}/tc?order={%$alaData.iteration%}&vit=osres&ref={%$pageData.pageRef%}&from={%$reqData.from%}&ssid={%$reqData.ssid%}&uid={%$reqData.uid%}&bd_page_type={%$reqData.bd_page_type%}&pu={%$reqData.pu%}&lid={%$reqData.lid%}{%if $alaData.appid%}&laid={%$alaData.appid%}{%/if%}&fm={%$_alaFm%}{%if $alaData.config.waplog%}&waplogo=1{%/if%}&l={%if $alaData.config.l%}{%$alaData.config.l%}{%else%}1{%/if%}&tj={%$alaData.enresourceid%}_{%$alaData.iteration%}_{%$reqData.pn%}_{%$reqData.rn%}_" scope="root"%}
{%/function%}

{%function name='alaGetAttribute' var=''%}
{%if is_array($var)%}
{%$var|json_encode|replace:'"':'&quot;'%}
{%else%}
{%$var|replace:'"':'&quot;'%}
{%/if%}
{%/function%}

{%function name="alaTplInfo"%}
{%if $pageData.tpl == 'iphone' || $pageData.tpl == 'pad' || $pageData.tpl == 'utouch'%}
{%if $alaData.resourceid%}srcid="{%$alaData.resourceid%}{%if $alaData.wnor_random%}{%$alaData.wnor_random%}{%else if $alaData.appid && $alaData.idrand%}_{%rand()%}{%/if%}"{%/if%}
{%if $pageData.tpl != 'utouch'%} order="{%$alaData.iteration%}" tpl="{%$smarty.current_dir|basename%}" data-log="{'fm':'{%$_alaFm%}','ensrcid':'{%$alaData.enresourceid%}','order':'{%$alaData.iteration%}'{%if $alaData.config.waplogo%},'waplogo':1{%/if%}{%if $alaData.appid%},'laid':'{%$alaData.appid%}'{%/if%},'mu':'{%if $tplData.url%}{%$tplData.url%}{%elseif $tplData.titleurl%}{%$tplData.titleurl%}{%/if%}'}"{%if $alaData.appid%} appid="{%$alaData.appid%}"{%/if%}{%/if%}
{%/if%}
{%/function%}

{%function name="alaDomData" class="" data=[] top=0%}
{%$cls=[]%}
{%if $top%}{%if $pageData.tpl == 'iphone' || $pageData.tpl == 'pad'%}{%$cls=['result']%}{%else%}{%$cls=['resitem']%}{%/if%}{%/if%}
{%if !empty($class)%}{%$cls[]=$class%}{%/if%}
{%if !empty($data.class)%}{%$cls[]=$data.class%}{%/if%}
{%$cls=join(' ',$cls)%}
{%if $cls%} class="{%$cls%}"{%/if%}{%if $top%} {%alaTplInfo%}{%/if%}{%foreach $data as $k => $v%}{%if $k!='class'%} {%$k%}="{%alaGetAttribute var=$v%}"{%/if%}{%/foreach%}
{%/function%}

{%function name='alaTcUrl' src='' tj5='l' waplogo='' undecode='' l='1' dict='' laid=''%}
{%if is_array($src)&&$src.query%}
{%$src={%wiseMakeSearchUrl word=$src.query sa="re_{%$alaData.iteration%}"%}%}
{%/if%}
{%* sto参数校验 *%}
{%if !empty($waplogo) && !empty($laid)%}
{%wiseMakeTcUrlNew src=$src alaData=$alaData fm=$_alaFm|default:'alop' tj5=$tj5 waplogo=$waplogo laid=$laid undecode=$undecode l=$l dict=$dict%}
{%elseif !empty($waplogo)%}
{%wiseMakeTcUrlNew src=$src alaData=$alaData fm=$_alaFm|default:'alop' tj5=$tj5 waplogo=$waplogo undecode=$undecode l=$l dict=$dict%}
{%elseif !empty($laid)%}
{%wiseMakeTcUrlNew src=$src alaData=$alaData fm=$_alaFm|default:'alop' tj5=$tj5 laid=$laid undecode=$undecode l=$l dict=$dict%}
{%else%}
{%wiseMakeTcUrlNew src=$src alaData=$alaData fm=$_alaFm|default:'alop' tj5=$tj5 undecode=$undecode l=$l dict=$dict%}
{%/if%}
{%/function%}

{%function name="alaModuleStart" modName="unknown" modData=[] htmlData=[] parentData=[] top=0%}
{%if !empty($parentData)%}
{%if !empty($parentData.class) && !empty($htmlData.class)%}
{%$parentData.class=$htmlData.class|cat:' '|cat:$parentData.class%}
{%/if%}
{%$htmlData=array_merge($htmlData, $parentData)%}
{%/if%}
{%call name="{%$modName%}_{%$alaKey%}" modData=$modData htmlData=$htmlData top=$top%}
{%$alaModuleStart|array_pop%}
{%/function%}

{%function name="alaModuleEnd"%}
{%$alaModuleEnd|array_pop%}
{%/function%}

{%function name="alaModule" modName="unknown" modData=[] htmlData=[] top=0 parentData=[]%}
{%if !empty($parentData)%}
{%if !empty($parentData.class) && !empty($htmlData.class)%}
{%$parentData.class=$htmlData.class|cat:' '|cat:$parentData.class%}
{%/if%}
{%$htmlData=array_merge($htmlData, $parentData)%}
{%/if%}
{%call name="{%$modName%}_{%$alaKey%}" modData=$modData htmlData=$htmlData top=$top%}
{%$alaModuleStart|array_pop%}
{%$alaModuleEnd|array_pop%}
{%/function%}

{%function name="alaName" s=""%}{%Search_AladdinFactory::getShortName($s)%}{%if $reqData.pn>=$reqData.rn%}{%$reqData.pn/$reqData.rn%}{%/if%}{%/function%}

{%block name="alaDom"%}{%/block%}

{%* 相关推荐 *%}
{%function fe_fn_c_recommend hints=''%}
{%/function%}


{%function fe_fn_c_box_adaptive_prefix query='' sa='' st='' url='' pl='' tx='' undecode='' ltj='l' laid='' waplogo='' dict='' vmgdb='' xse='' class=''%}
{%if $query%}
	{%$url={%wiseMakeSearchUrl word=$query sa=$sa|default:"re_{%$alaData.iteration%}" st=$st%}%}
{%/if%}
{%if $url%}<a class="{%$class%}" href="{%alaTcUrl pl="$pl" tx=$tx src=$url undecode=$undecode tj5=$ltj laid=$laid     waplogo=$waplogo dict=$dict vmgdb=$vmgdb%}" {%if $xse%}data-xse="{%$xse%}"{%/if%}{%else%}<div{%/if%} class="{%$class%}">
{%/function%}
{%function fe_fn_c_box_adaptive_suffix url=''%}
{%if $url%}
</a>
{%else%}
</div>
{%/if%}
{%/function%}

{%* makeurl query:nodefault/sa:default|re_index/st:default|11108i *%}
{%function name=fe_fn_c_build_url%}{%wiseMakeSearchUrl word=$wd sa=$sa|default:"re_{%$alaData.iteration%}_{%$alaData.resourceid%}" st=$st|default:"11108i"%}{%/function%}

{%* imghandle for delaysrc imgsrc:图片地址 type:default/s   ——  l/竖图；s/方图；w/宽图 *%}
{%function name=fe_fn_c_img_delay size=60 imgattr="data-imagedelaysrc"%}
    <div class="c-img c-img-{%$type|default:"s"%}">
	    <img {%$imgattr%}="{%Utils_Common::timgUrl($imgsrc, 8, $size)%}" />
	</div>
{%/function%}

{%* 计算栅格图片宽度百分比 *%}
{%function name=fe_fn_c_img_wrate col=3%}
	{%(55 * $col - 24) / 636 * 100%}
{%/function%}
{%* 计算滑动组件父容器宽度 *%}
{%function name=fe_fn_c_img_scroll_pwrate col=3 num=''%}
	{%if $num%}
		{%{%fe_fn_c_img_wrate col=$col%} * $num|cat:'%'%}
	{%/if%}
{%/function%}

{%* text-inline highlight *%}
{%function fe_fn_c_text_inline query='' sa='' st='' url='' text='' highlight='' l='' pl='' tx='' undecode='' ltj='l' laid='' waplogo='' dict='' vmgdb='' xse=''%}
    {%if $query%}
	    {%$url={%wiseMakeSearchUrl word=$query sa="re_`$alaData.iteration`"  st=$st%}%}
    {%else%}
        {%$url=$url%}
    {%/if%}
	{%if !$highlight%}
		{%$highlight = $alaData.hilightstr%}
	{%else%}
		{%$highlight = iconv('utf-8', 'gbk', $highlight)%}
	{%/if%}
	{%if $highlight%}
	    {%*assign var="useless" value=(''|cat: $highlight)*%}
		{%$tmpText={%$text|wordtranscode:"UTF-8":"GBK"|@hilight_print:$highlight|wordtranscode:"GBK":"UTF-8"|@htmlspecialchars_decode%}%}
    {%else%}
	    {%$tmpText=$text%}
    {%/if%}	
	{%if $url%}
		<a href="{%alaTcUrl src=$url undecode=$undecode tj5=$ltj laid=$laid waplogo=$waplogo dict=$dict%}" {%if $xse%}data-xse="{%$xse%}"{%/if%}>{%$tmpText%}</a>
	{%else%}
		<span>{%$tmpText%}</span>
	{%/if%}
{%/function%}
{%function fe_fn_c_title %}
	<h3 class="c-title c-gap-top-small">{%fe_fn_c_text_inline text=$tplData.title highlight='' %}</h3>
{%/function%}
{%function fe_fn_c_showUrl leftUrl='' leftText='' rightUrl='' rightText='' hasArrow='' undecode=''%}
    <div class="c-span6">
		{%fe_fn_c_box_adaptive_prefix url=$leftUrl undecode=$undecode class='c-line-clamp1'%}
			{%if $leftText%}
				<span class="c-color-gray">{%$leftText%}</span>
				{%$tmpType = 'aladdin'%}
				{%if $tplData.showUrlType%}
					{%$tmpType = 'lightapp'%}
				{%/if%}
				<span class="c-foot-icon c-foot-icon-16 c-foot-icon-16-{%$tmpType%} c-gap-left-small"></span>
			{%/if%}
		{%fe_fn_c_box_adaptive_suffix url=$leftUrl%}
	</div>
	<div class="c-span6">
		{%fe_fn_c_box_adaptive_prefix url=$rightUrl undecode=$undecode class="c-blocka c-moreinfo"%}
			{%if $rightText || $rightUrl%}
				{%$rightText%}<i class="c-icon c-gap-left-small">&#xe734</i>
			{%/if%}
		{%fe_fn_c_box_adaptive_suffix url=$rightUrl%}
	</div>
{%/function%}


{%* 模板修改数据模块 *%}
{%block name="data_modifier"%}
{%/block%}

{%* 模板主体框架 *%}
{%block name="main_container"%}
{%alaEngine%}
{%block name="card_prefix"%}{%/block%}
<div class="result c-container{%if $tplData.isIphoneOnly%} c-container-tile {%$tplData.isIphoneOnly%}{%/if%}" srcid="{%$alaData.resourceid%}" {%alaTplInfo%}>
		{%block name="title"%}
        {%fe_fn_c_box_adaptive_prefix url=$tplData.url ltj="title" class="c-blocka" undecode=$tplData._urlUndecode%}
        {%fe_fn_c_title%}
        {%fe_fn_c_box_adaptive_suffix url=$tplData.url%}
        {%/block%}
        {%block name="content"%}{%/block%}
        {%block name="foot"%}
        <div class="c-row">
		    {%fe_fn_c_showUrl leftUrl=$tplData.showLeftUrl leftText=$tplData.showLeftText rightUrl=$tplData.showRightUrl rightText=$tplData.showRightText undecode=$tplData._urlUndecode%}
		</div>
        {%/block%}

{%if (($resultDispData.sublink.is_main && $resultDispData.sublink.is_main==1) || $resultDispData.strategybits.OFFICIALPAGE_FLAG) && $templateConfig.prerender == "1"%}
<link rel="prerender" href="{%$tplData.url|escape%}" data-newtab="true">
{%/if%}
{%if $tplData.hints%}
{%fe_fn_c_recommend hints=$tplData.hints%}
{%/if%}
</div>
{%block name="card_suffix"%}{%/block%}
{%/block%}






