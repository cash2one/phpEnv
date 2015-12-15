{%extends "search/searchaladdin/c_base/iphone.tpl"%} 
{%block name='data_modifier'%}
    {%if $tplData.result && !$tplData.result[0]%}
	    {%$tplData.result = [$tplData.result]%}
	{%/if%}
    {%if !$tplData.result[0].newest_tip%}
        {%$tplData.result[0].newest_tip='即将上映'%}
    {%/if%}
    {%if !$tplData.result[0].downrighttip.text%}
        {%$tplData.result[0].downrighttip.text='更多精彩花絮'%}
    {%/if%}
    {%$escaped_alias=""%}
    {%if $tplData.result[0].show_alias && (strpos($tplData.OriginQuery, $tplData.result[0].show_name) === false)%}
        {%foreach $tplData.result[0].show_alias as $item%}
            {%if strpos($tplData.OriginQuery, $item) !== false%}
                {%$escaped_alias = $item%}
				{%break%}
            {%/if%}
        {%/foreach%}
    {%/if%}
    
    {%$escaped_info = []%}
	
    {%if $tplData.result[0].releaseTime%}{%$escaped_info[] = $tplData.result[0].releaseTime%}{%/if%}
    {%if $tplData.result[0].area%}{%$escaped_info[] = $tplData.result[0].area%}{%/if%}
    {%if $tplData.result[0].lang%}{%$escaped_info[] = $tplData.result[0].lang%}{%/if%}
    
    {%$escapedResult[0]=[]%}
    {%$escapedNum=0%}
    {%$escaped_nowVsn=$tplData.result[0].se_uri%}
    
    {%foreach $tplData.result as $itemSite%}
        {%if $itemSite.episode && !$itemSite.episode[0]%}
            {%$tplData.result[$itemSite@index].episode=array($itemSite.episode)%}
        {%/if%}
        
        {%if $itemSite.se_uri != $escaped_nowVsn%}
            {%$escapedNum = $escapedNum+1%}
            {%$escaped_nowVsn = $itemSite.se_uri%}
            {%$escapedResult[$escapedNum]=[]%}
        {%/if%} 
        
		{%$escaped_nowtit=''%}
        
        {%if $escaped_alias && (strpos($escaped_alias,$itemSite.show_name)===false)%}
            {%$escaped_nowtit=$itemSite.show_name%}
            {%if $itemSite.show_version && !preg_match("/版/",$itemSite.show_name) %}
                {%$escaped_nowtit=$escaped_nowtit|cat:' '|cat:$itemSite.show_version%}
            {%/if%}
            {%$escaped_nowtit=$escaped_nowtit|cat:'(又名'|cat:$escaped_alias|cat:')'|cat:$itemSite.title_suf%}
            {%$tplData.result[$itemSite@index].showala=false%}
        {%/if%}
        {%if !$escaped_alias || !(strpos($escaped_alias,$itemSite.show_name)===false)%}
            {%$escaped_nowtit=$itemSite.show_name|cat:$itemSite.show_version|cat:$itemSite.title_suf%}
            {%$escaped_nowtit=$itemSite.show_name%}
            {%if $itemSite.show_version  && !preg_match("/版/",$itemSite.show_name) %}
                {%$escaped_nowtit=$escaped_nowtit|cat:' '|cat:$itemSite.show_version%}
            {%/if%}
            {%$escaped_nowtit=$escaped_nowtit|cat:$itemSite.title_suf%}
            {%$tplData.result[$itemSite@index].showala=true%}  
        {%/if%}
        {%$tplData.result[$itemSite@index].title=$escaped_nowtit%}
        
        {%$escapedTemp=array_push($escapedResult[$escapedNum],$tplData.result[$itemSite@index])%}
    {%/foreach%}
    {%$tplData.title=$tplData.result[0].title%}
    {%$tplData.url=$tplData.result[0].url%}
	{%$tplData.showLeftText=$tplData.result[0].se_sitename%}
    {%$tplData.showRightText=$tplData.result[0].downrighttip.text%}
	{%$tplData.showRightUrl=$tplData.result[0].downrighttip.link%}
	{%$entityWidth = 100/count($tplData.result[0].episode)%}
	{%$scrollerWidth = (55*5-24)/6.6*count($tplData.result[0].episode)%}
{%/block%}
{%block name='content'%}
<style>
	.wa-vd-variety-scroll-playicon{color:#fff;position:absolute;left:4px;bottom: -1px;}
	.wa-vd-variety-logo-wapper, .wa-vd-variety-scroll-image{position:relative}
	.wa-vd-variety-scroll-entity{display:inline-block;vertical-align: top;}
	.wa-vd-variety-logo-wapper{overflow:hidden;margin:4px 0;}
	.wa-vd-variety-logo-wapper .c-img{margin:0}
	
	.wa-vd-variety-logo {
		-webkit-transform: rotate(45deg);
		-ms-transform: rotate(45deg);
		transform: rotate(45deg);
		border-bottom: 1px solid #cd0c00;
		border-top: 1px solid #cd0c00;
		right: -15px;
		top: 11px;
		width: 68px;
		height: 16px;
		position: absolute;
		font-size: 10px;
		text-align: center;
		line-height: 16px;
		background-color: #db342a;
		color:#fff;
	}
</style>
	<div class="c-row c-gap-bottom c-gap-top-small">
    	<div class="c-span4">
            {%fe_fn_c_box_adaptive_prefix url={%$tplData.result[0].url%} ltj="p" class="c-blocka wa-vd-variety-logo-wapper"%}
                {%fe_fn_c_img_delay imgsrc={%$tplData.result[0].poster%} type="l"%}
				<p class="wa-vd-variety-logo">{%$tplData.result[0].newest_tip%}</p>
            {%fe_fn_c_box_adaptive_suffix url={%$tplData.result[0].url%} %}
        </div>
        <div class="c-span8">
			{%if $tplData.result[0].newest_episode%}
				<p class="c-line-clamp1"><span class="c-gap-right-small c-color-gray">开播：</span><span>{%if $tplData.result[0].exactreleaseTime%}{%$tplData.result[0].exactreleaseTime%}{%else%}{%$tplData.result[0].newest_episode%}{%/if%}</span></p>
			{%/if%}
			{%if $tplData.result[0].se_area%}
				<p class="c-line-clamp1"><span class="c-gap-right-small c-color-gray">国家：</span><span>{%$tplData.result[0].se_area%}</span></p>
			{%/if%}
			{%if $tplData.result[0].type%}
				{%if !$tplData.result[0].type[0]%}
                    {%$tplData.result[0].type=array($tplData.result[0].type)%}
                {%/if%}
				<p class="c-line-clamp1">
					<span class="c-gap-right-small c-color-gray">类型：</span>
					<span>
						{%foreach  array_slice($tplData.result[0].type, 0) as $item%}
							<span>{%$item.name%}</span>
							{%if !$item@last%}
								<span class="c-color-gray-a">/</span>
							{%/if%}
						{%/foreach%}
					</span>
				</p>
			{%/if%}
			{%if $tplData.result[0].actor%}
				{%if !$tplData.result[0].actor[0]%}
                    {%$tplData.result[0].actor=array($tplData.result[0].actor)%}
                {%/if%}
                {%if !$tplData.result[0].actor[0].performanceType%}
                    {%$tplData.result[0].actor[0].performanceType='主演'%}    
                {%/if%}
				<p class="c-line-clamp1">
					<span class="c-gap-right-small c-color-gray">{%$tplData.result[0].actor[0].performanceType|cat:'：'%}</span>
					<span>
						{%foreach  array_slice($tplData.result[0].actor, 0,5) as $item%}
							<span>{%$item.name%}</span>
							{%if !$item@last%}
								<span class="c-color-gray-a">/</span>
							{%/if%}
						{%/foreach%}
					</span>
				</p>
			{%/if%}
			{%if $tplData.result[0].summary%}
                <p class="c-line-clamp3">
                    <span class="c-color-gray">简介：</span><span>{%if $escaped_alias && $tplData.result[0].showala%}（又名：<em>{%$escaped_alias%}</em>）{%/if%}{%$tplData.result[0].summary.content%}</span></p>
            {%/if%} 

            
        </div>
    </div>
	{%if $tplData.result[0].episode%}
		<div class="c-line-top c-gap-bottom-small">
				<div class="c-row-tile c-gap-top c-scroll-wrapper wa-vd-variety-scroll-wrapper">
					<div class="c-scroll-parent-gap wa-vd-variety-scroller" style="width:{%$scrollerWidth%}%">
						{%foreach $tplData.result[0].episode as $item%}
							<div class="c-scroll-element-gap wa-vd-variety-scroll-entity" style="width:{%$entityWidth%}%">
								{%fe_fn_c_box_adaptive_prefix url=$item.url ltj='l' class="c-color"%}
									<div class="wa-vd-variety-scroll-image">
										{%fe_fn_c_img_delay imgsrc={%$item.img_url%} type="w"%}
										<p class="wa-vd-variety-scroll-playicon c-icon">&#xe735</p>
									</div>
									<p class="c-line-clamp2 c-gap-top-small">{%$item.title%}</p>
								{%fe_fn_c_box_adaptive_suffix url=$item.url%}
							</div>
						{%/foreach%}
					</div>
				</div>
		</div>
	{%/if%}

<script data-merge>
A.init(function () {
            var self = this;
            var init = function () {
                require([
                    'uiamd/iscroll/iscroll'
                ], function (IScroll) {
                    new IScroll('.wa-vd-variety-scroll-wrapper', {
                        disableMouse: true,
                        scrollX: true,
                        scrollY: false,
                        eventPassthrough: true,
                        scrollbars: false

                    });
                });
            };
            $(self.container).on('onlyshowMore', init);
            A.onload(init);
        });
});

</script>
{%/strip%}{%/block%}

A.init(function(){
        