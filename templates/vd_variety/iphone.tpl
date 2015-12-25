{%extends "search/searchaladdin/c_base/iphone.tpl"%} 
{%block name='data_modifier'%}
    {%if $tplData.result && !$tplData.result[0]%}
	    {%$tplData.result = [$tplData.result]%}
	{%/if%}

	{%*简介里面的别名*%}
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
            {%$tplData.result[$itemSite@index].episode = [$itemSite.episode] %}
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


	{%*title,foot数据*%}
    {%$tplData.title=$tplData.result[0].title%}

    {%*title的url是第一个list的url*%}
    {%$tplData.url = $tplData.result[0].episode[0].url%}

	{%$tplData.showLeftText=$tplData.result[0].se_sitename%}
    {%$tplData.showRightText='查看更多'%}
	{%$tplData.showRightUrl=$tplData.result[0].url%}

	{%*计算scroll宽度*%}
    {%$episode_len = count($tplData.result[0].episode)%}
	{%$entityWidth = {%1/$episode_len*100|cat:"%"%} %}
	{%$scrollerWidth = {%fe_fn_c_img_scroll_pwrate col=4 num=$episode_len%}%}
{%/block%}
{%block name='content'%}
<style>
	.wa-vd-variety-scroll-playicon{
        overflow:hidden;color:#fff;position:absolute;left:0;bottom:0;width:100%;
        background-color: rgba(0,0,0,0.6);
    }
	.wa-vd-variety-scroll-image{position:relative}
	.wa-vd-variety-scroll-entity{display:inline-block;vertical-align: top;}
	.wa-vd-variety-logo-wapper .c-img{margin:0}
    .wa-vd-variety-data{
        float:right;
        margin-right:3px;
        font-size:12px;
    }
    .wa-vd-variety-icon{
        margin-left:3px;
        position: relative;
        top:-1px;
    }
    @media only screen and (max-width: 322px) {
        .wa-vd-variety-scroll-image .c-icon{
            display: none;
        }

        .wa-vd-variety-data{
            float: inherit;
        }

        .wa-vd-variety-scroll-playicon{
            text-align: center;
        }
    }

</style>
	<div class="c-row c-gap-bottom c-gap-top-small">
    	<div class="c-span4">
            {%fe_fn_c_box_adaptive_prefix url={%$tplData.result[0].url%} ltj="p" class="c-blocka wa-vd-variety-logo-wapper"%}
                {%fe_fn_c_img_delay imgsrc={%$tplData.result[0].poster%} size=100 type="l"%}
            {%fe_fn_c_box_adaptive_suffix url={%$tplData.result[0].url%} %}
        </div>
        <div class="c-span8">
			{%if $tplData.result[0].newest_episode%}
				<p class="c-line-clamp1"><span class="c-gap-right-small c-color-gray">更新：</span><span>{%if $tplData.result[0].exactreleaseTime%}{%$tplData.result[0].exactreleaseTime|escape%}{%else%}{%$tplData.result[0].newest_episode|escape%}{%/if%}</span></p>
			{%/if%}
			{%if $tplData.result[0].se_area%}
				<p class="c-line-clamp1"><span class="c-gap-right-small c-color-gray">国家：</span><span>{%$tplData.result[0].se_area|escape%}</span></p>
			{%/if%}
			{%if $tplData.result[0].type%}
				{%if !$tplData.result[0].type[0]%}
                    {%$tplData.result[0].type=[$tplData.result[0].type]%}
                {%/if%}
				<p class="c-line-clamp1">
					<span class="c-gap-right-small c-color-gray">类型：</span>
					<span>
						{%foreach  array_slice($tplData.result[0].type, 0) as $item%}
							<span>{%$item.name|escape%}</span>
							{%if !$item@last%}
								<span class="c-color-gray-a">/</span>
							{%/if%}
						{%/foreach%}
					</span>
				</p>
			{%/if%}
			{%if $tplData.result[0].actor%}
				{%if !$tplData.result[0].actor[0]%}
                    {%$tplData.result[0].actor = [$tplData.result[0].actor] %}
                {%/if%}
                {%if !$tplData.result[0].actor[0].performanceType%}
                    {%$tplData.result[0].actor[0].performanceType='主演'%}    
                {%/if%}
				<p class="c-line-clamp1">
					<span class="c-gap-right-small c-color-gray">{%$tplData.result[0].actor[0].performanceType|cat:'：'|escape%}</span>
					<span>
						{%foreach  array_slice($tplData.result[0].actor, 0,5) as $item%}
							<span>{%$item.name|escape%}</span>
							{%if !$item@last%}
								<span class="c-color-gray-a">/</span>
							{%/if%}
						{%/foreach%}
					</span>
				</p>
			{%/if%}
			{%if $tplData.result[0].summary%}
                <p class="c-line-clamp3">
                    <span class="c-color-gray">简介：</span><span>{%if $escaped_alias && $tplData.result[0].showala%}（又名：<em>{%$escaped_alias|escape%}</em>）{%/if%}{%$tplData.result[0].summary.content|escape%}</span></p>
            {%/if%} 

            
        </div>
    </div>
	{%if $tplData.result[0].episode%}
		<div class="c-line-top c-gap-bottom-small">
				<div class="c-row-tile c-gap-top c-scroll-wrapper wa-vd-variety-scroll-wrapper">
					<div class="c-scroll-parent-gap wa-vd-variety-scroller" style="width:{%$scrollerWidth%}">
						{%foreach $tplData.result[0].episode as $item%}
							<div class="c-scroll-element-gap wa-vd-variety-scroll-entity" style="width:{%$entityWidth%}">
								{%fe_fn_c_box_adaptive_prefix url=$item.url ltj='l' class="c-color"%}
									<div class="wa-vd-variety-scroll-image">
										{%fe_fn_c_img_delay imgsrc={%$item.img_url%} size=100 type="x"%}
										<p class="wa-vd-variety-scroll-playicon"><span class="wa-vd-variety-icon c-icon">&#xe735</span><span class="wa-vd-variety-data">{%$item.date|escape%}</span></p>
									</div>
									<p class="c-line-clamp2 c-gap-top-small">{%$item.title|escape%}</p>
								{%fe_fn_c_box_adaptive_suffix url=$item.url%}
							</div>
						{%/foreach%}
					</div>
				</div>
		</div>
	{%/if%}

<script data-merge>
A.init(function(){
		var self = this;
		require([ 'uiamd/iscroll/bdscroll' ], function (IScroll) {
			var scroll = new IScroll('.wa-vd-variety-scroll-wrapper', {
				disableMouse: true,
				scrollX: true,
				scrollY: false,
				eventPassthrough: true,
				scrollbars: false

			});

			$('body').on('onlyshowMore', function(){
				setTimeout(function(){
					scroll.refresh();	
				},0);
			});
		});
});

</script>
{%/strip%}{%/block%}

