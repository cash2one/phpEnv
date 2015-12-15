{%extends "search/searchaladdin/c_base/iphone.tpl"%}

{%block name="data_modifier"%}
	{%if !$tplData.result[0]%}
		{%$tplData.result = [$tplData.result]%}
	{%/if%}
	{%$r1 = $tplData.result[0]%}
	{%if !$r1.vlink[0]%}
		{%$r1.vlink= [$r1.vlink]%}
		{%$r1.vlink_num_baidu = 1%}
	{%/if%}

	{%$tplData.title = $r1.se_class|cat:$r1.show_name%}

	{%$tplData.url = $r1.url%}
	{%if !$r1.actor[0]%}
		{%$r1.actor = [$r1.actor] %}
	{%/if%}
	
	{%$actors = implode(' / ',explode('$',$r1.se_actor))%}
	{%$type = implode(' / ',explode('$',$r1.se_type))%}

	{%$key = urlencode($r1.show_name)%}
	{%$cardBdbox = []%}
	{%$cardBdbox.card_id = {%'009_'|cat:$key%} %}
	{%$cardBdbox.word = $tplData.OriginQuery %}
	{%$cardBdbox.fetchkey = $r1.show_name %}
	{%$cardBdbox.resource_id = "3100" %}
	{%$cardBdbox.resource_name = 'tv' %}

	{%$cardBdbox.season = preg_replace("/\D*/","",$r1.season)%}
	{%$cardBdbox.csrc = 'app_mainbox_txt' %}
	{%$cardBdbox.dsp = 'iphone' %}
	{%$cardBdbox.tn = 'wisexmlnew' %}
	{%$cardBdbox.type = "2" %}

	{%$cardBdbox = json_encode($cardBdbox)%}

{%/block%}

{%block name="title"%}
{%/block%}

{%block name="foot"%}
{%/block%}

{%block name="content"%}{%strip%}
<style>

.wa-longvideo-scrollor{
	overflow-x:hidden;
	position: relative;
}

.wa-longvideo-scrollor ul{
	width:200%;
}

.wa-longvideo-scrollor li{
	width:50%;
	display: inline-block;
	vertical-align:top;
}

.wa-longvideo-scrollor li:nth-of-type(1){ 
}
.wa-longvideo-scrollor li:nth-of-type(2){ 
}

.wa-vdtv-logo{
	vertical-align: middle;
	position: relative;
	top: -2px;
	margin-right:3px;
}
.wa-vdtv-change .c-icon{
	margin-right:5px;
	position: relative;
	top:-1px;
}

.wa-vdtv-hx-title{
	width:auto;
	position: relative;
	padding-right:20px;
}


.wa-vdtv-vlist .c-slink{
	-webkit-justify-content:flex-start;
}

.wa-vdtv-vlist .c-slink a{
	-webkit-box-flex:inherit;
	-webkit-flex:inherit;
}

.wa-vdtv-btn{
	background-color:#0C77E5;
	color:#fff;
	border-color:#0C77E5;
	padding:0;
}

.wa-vdtv-btn .c-icon{
	margin:0;	
}
</style>

<div class="wa-longvideo-scrollor">
	<ul>
		<li>
			{%fe_fn_c_box_adaptive_prefix url=$tplData.url ltj="title" class="c-blocka"%}
			{%fe_fn_c_title%}
			{%fe_fn_c_box_adaptive_suffix url=$tplData.url%}

			<div class="c-row">
				<div class="c-span4">
					{%fe_fn_c_img_delay type="l" imgsrc={%$r1.poster%}%}
				</div>
				<div class="c-span8">  
					<div class=""><img class="wa-vdtv-logo" src="{%Utils_Common::timgUrl($r1.site_logo,8,60)%}" />{%$r1.se_sitename%}全集 </div>	
					<div class=""><span class="c-text-box c-text-box-blue" style="position: relative;top:-1px;">{%if $r1.finish%}已完结{%else%}正在更新{%/if%}</span> {%$r1.totalEp%}集全</div>	
					<div class="c-line-clamp1">年代:&nbsp;{%$r1.se_year%} <span>&nbsp;地区:&nbsp;{%$r1.area%}</span></div>
					<div class="c-line-clamp1">类型:&nbsp;{%$type%}</div>
					<div class="c-line-clamp1">主演:&nbsp;{%$actors%}</div>
					<div class="c-row c-gap-top-small">
						<div class="c-span6">
							{%fe_fn_c_box_adaptive_prefix url=$r1.vlink[0].linkurl class="c-btn wa-vdtv-btn" %}
								<span class="c-icon" style="color:#fff;">&#xe732</span>立即播放
							{%fe_fn_c_box_adaptive_suffix url=$r1.vlink[0].linkurl %}
						</div>
						<div class="c-span6">
							{%if $reqData.tn=="zbios"%}
							{%**框内添加卡片**%}
								<input type="hidden" data-cardbdboxadder="{%$cardBdbox|escape:html%}" data-add-txt="追剧" data-added-txt="已追此剧" data-cardfromand="1005900j" data-cardfromios="1005900k"/>
								<script>
									A.init(function(){
										var opt = {
											css: '',
											minVersion: '',
											template: '<div class="<%=wrapper_cls%>"><div class="<%=add_cls%> c-btn" href="javascript:void(0)"><%=add_txt%></div><div style="display:none" class="c-btn WA_LOG_BTN <%=added_cls%>"><%=added_txt%></div></div>'
										};
										var self = this;
										require(['uiamd/bdbox/base','uiamd/bdbox/card'],function($,card){
											card(self.container,opt)
										});

									});
								</script>
							{%/if%}
						</div>

					</div>
				</div>
			</div>


			{%*下拉框*%}
			<div class="c-row c-gap-top">
				<div class="c-dropdown c-span12">
					<select class="wa-vdtv-selector">
						{%$me=floor($r1.vlink_num_baidu/10)%}
						{%if $r1.vlink_num_baidu%10 == 0%}
							{%$me = $me - 1%}	
						{%/if%}
						{%$i=$me%}
						{%if $r1.vlink[0].linkcontent == $r1.vlink_num_baidu%}
							{%$isDaoxu=1%}
						{%/if%}
						{%for $i=0 to $me%}
							{%if $isDaoxu%}
								{%$to=$r1.vlink_num_baidu - $i*10%}
								{%$from=$to - 9%}
								{%if $from < 0%}
									{%$from = 1%}
								{%/if%}
							{%else%}
								{%$to=$i*10 + 1%}
								{%$from=$to + 9%}
								{%if $from > $r1.vlink_num_baidu%}
									{%$from = $r1.vlink_num_baidu%}
								{%/if%}
							{%/if%}

							<option value="{%$i*10%}" {%if $i==0 %} selected=1 {%/if%}>
								{%if $from - $to == 0%}
									{%$text="第{%$to%}集"%}
								{%else%}
									{%$text="第{%$to%}-{%$from%}集"%}
								{%/if%}

								{%$text%}
							</option>
						{%/for%}
					</select>
				</div>
			</div>


		{%* 剧集 *%}
		{%$list = array_slice($r1.vlink,0,10)%}
		{%$vcount = $list|count%}
        {%if $vcount>0%}
            <div class="wa-vdtv-vlist  c-gap-top-large">

                    {%foreach $list as $index=>$item%}
                        {%if $index % 5 == 0%}
                            <div class="c-slink c-slink-strong">
                        {%/if%}

						<a class="c-blocka" {%if $item.linkurl%}href="{%alaTcUrl tj5=l src=$item.linkurl%}" {%/if%} >
                            {%$item.linkcontent%}
                            {%if $item.latest %}
                                <i class="c-text-box c-text-box-red" style="position:absolute;top:0px; right:0px;">新</i>
                            {%/if%}
						</a>
                        {%if $index % 5 == 4%}
                            </div>
                         {%/if%}

                    {%/foreach%}
            </div>
        {%/if%}

			{%*花絮按钮*%}
			{%if $r1.expand_info == 1%}
			<div class="wa-vdtv-getMore WA_LOG_BTN c-color-gray-a c-gap-top" style="text-align: right">
				<span style="margin-right:3px;position: relative;top:-1px;" class="c-icon">&#xe629</span><span style="-webkit-tap-highlight-color:rgba(0,0,0,0);" class="">查看花絮</span>
			</div>
			{%/if%}
		</li>	

		{%*花絮卡片*%}
		<li>
			<h3 class="c-title c-gap-top-small c-flexbox">
				<div>{%$r1.show_name%}视频推荐</div>
				<div class="c-color-gray-a wa-vdtv-change WA_LOG_BTN" style="font-size:14px;"><span class="c-icon" >&#xe61d</span>换一批</div>
			</h3>				
			<div class="wa-longvideo-list">
			</div>	
			<div class="c-row c-gap-top c-color-gray wa-vdtv-back" style="display:none;position: absolute;bottom:0;left:50%;-webkit-transform:translate(15px,0);width:50%;">
				<div class="c-span6">百度智能推荐</div>
				<div class="c-span6 wa-vdtv-goHead c-color-gray-a WA_LOG_BTN" style="text-align: right"><span class="c-icon" style="position: relative;margin-right:3px;top:-1px;">&#xe62b</span><span style="-webkit-tap-highlight-color:rgba(0,0,0,0);">返回正片<span></div>
			</div>
		
		</li>
	</ul>
</div>


<script>
A.setup({
	pref:'{%$fe_var_tc_jump%}',
	hx_api:'{%"http://opendata.baidu.com/api.php?format=json&ie=utf-8&oe=utf-8&resource_id=11184&tn=wisexmlnew&need_di=1&query={%$r1.se_uri%}"|getHttpsHost%}',
	vlink_api:'{%"http://opendata.baidu.com/api.php?format=json&ie=utf-8&oe=utf-8&resource_id={%$tplData.resourceid%}&from_mid=1&co=vlink&arn=10&tn=wisetpl&dsp=iphone&need_di=1"|getHttpsHost%}' + '&query='+ '{%$tplData.fetchkey%}' +'&locsign={%$r1.se_locsign%}',
	expand:'{%$r1.expand_info%}'
});
</script>

<script data-merge>
A.init(function(){

	var tc_jump = (function(window,undefined){
		var init = function(pref){
			this.pref = pref;
			this.typeIndex = {l:0,p:0,g:0,f:0,b:0,t:0,title:0,footlink:0};
		};

		var fn = init.prototype;
		fn.getUrl = function(sec,di,src,type){
			type = type || "l";
			type !== "title" && this.typeIndex[type]++;
			return this.pref + type + this.typeIndex[type] + '&sec=' + sec + '&di=' + di + '&src=' + encodeURIComponent(src);
		};

		return init;
	
	})(this,window,undefined);


	var self = this,
		$ct = $(this.container),
		data_hx = null,
		pageNum = 0,
		nowPage = 0,
		size = 4,
		flag = 0,/*标识kv数据显示4条还是3条,0=4条*/
		tc = new tc_jump(this.data.pref);

	function getHttps(url){
		return  (window.B && B.https && B.https.domain && B.https.domain.get) ? B.https.domain.get(url) : url;	
	}

	function  build_hx(page){
		var p = '',
			data = data_hx,
			start = nowPage * size,
			end = start + size;
			if( (nowPage + 1 ) * size > data.list.length){end = data.list.length;}

		for (var i = start; i < end; i++) {
			var item = data.list[i];
			p += '<a ';
				if(flag>0 && i == end - 1){
					p += 'style="display:none;"';	
				} 
				p += ' class="c-blocka" href="'+ tc.getUrl(item.sec,item.url_di,item.url)  +'" ><div '; if (i != end - 1) { p += ' class="c-line-bottom" '; } p += ' >';
				if (i < start + 2) {
					p += '<div class="c-row c-gap-top c-gap-bottom">' +
							'<div class="c-span3">'+
								'<div class="c-img c-img-s">'+
									'<img src="' + item.imgurl + '"/>'+
								'</div>'+
							'</div>';
						p += '<div class="c-span9">'+
								'<div class="c-line-clamp1"><span style="position:relative;top:-1px;margin-right:3px;" class="c-text-box c-text-box-red">新</span><span class="c-color-link">' + item.title + '<span></div>'+ 
								'<div class="c-color-gray  c-line-clamp1">作者 :' + item.author + '</div>'+
								'<div class="c-color-gray  c-flexbox"><div style="-webkit-box-flex:1;">来自 :' + item.from + '</div><div>' + item.num  + '</div></div>'+
							'</div>'+
						'</div>';
				} else {
					p += '<div class="c-flexbox c-gap-top c-gap-bottom">'+
							'<div class="c-line-clamp1 c-color-link" style = "width:70%;">' + item.title + '</div> <div class="c-color-gray" style="white-space:nowrap;" >' +  item.num +  '</div>'+
						'</div>';
				}
			p += '</div> </a>';
		}
		return p;	
	}

	function build_vlink(data){
		var p = '',
			len = data.vlink.length;

		/*如果只有一行剧集,侧滑页只显示3条数据*/
		if(len < 6){
			flag = 1;
			$('.wa-longvideo-list a').eq('3').hide();
		}else{
			flag = 0;
			$('.wa-longvideo-list a').eq('3').show();
		}

		for( var i = 0; i < len; i++){
			var item = data.vlink[i];
			if( i % 5 === 0){
				p += '<div class="c-slink c-slink-strong">';
			}
					p += '<a class="c-blocka"';
					if(item.linkurl){
						p += 'href="' + item.linkurl; 
					}	
					p +=  '">' + item.linkcontent ; if( item.latest ){ p += '<i style="position:absolute;top:0px; right:0px;" class="c-text-box c-text-box-red">新</i>';  }  p+='</a>';

			if( i % 5 === 4 || i === len - 1){
				p += '</div>';
			}
		}

		return p;

	}
		
	function success_2(res){
		var str = build_vlink(res.data[0]['disp_data'][0]);
		document.querySelector(".wa-vdtv-vlist").innerHTML = str;
	}

	/*获取首页数据*/
	function getVlink(pn,fail){
		$.ajax({
			url:self.data.vlink_api + '&apn=' + pn,
			jsonp:"cb",
			dataType:"jsonp"
		}).done(success_2).fail(fail);
	}

	/*判断是否展现花絮*/
	if(this.data.expand === '1'){
		require(['uiamd/iscroll/Bscroll'], function (BScroll){
			var option = {
				snap:true,
				snapSpeed: 400, 
				gOrder:2,
				$container:$(self.container),
				className:'.wa-longvideo-scrollor',
				cb:function(longvideoScroll){
					
					$('body').one('onlyshowMore', function () {
						setTimeout(function() {
							longvideoScroll.refresh();
						}, 0);
					});


					/*获取侧滑页数据,渲染,绑定事件*/
					function getHx(fail){
						var url =  self.data.hx_api;
						$.ajax({
							url:url,
							jsonp:"cb",
							dataType:"jsonp"
						}).done(function(res,status,xhr){
							data_hx = res['data'][0];	
							pageNum = Math.ceil(res['data'][0].list.length / size);
							var str = build_hx(0);
							document.querySelector(".wa-longvideo-list").innerHTML = str;
						}).done(function(){
							$ct.find('.wa-vdtv-change').on("click",function(){
								nowPage = (nowPage + 1) %  ( pageNum - 1 );
								var str = build_hx(nowPage);
								document.querySelector(".wa-longvideo-list").innerHTML = str;
							});

							$ct.find('.wa-vdtv-back').show();
							$ct.find('.wa-vdtv-goHead').on("click",function(){
								longvideoScroll.prev();	
							});
						
						}).fail(fail);
					}

					/*绑定花絮事件*/
					function bindEvt(){
						$ct.find('.wa-vdtv-getMore').on("click",function(){
							longvideoScroll.next();	
						});

					}

					bindEvt();
					getHx(function(){
						$ct.find(".wa-vdtv-getMore").remove();
					});
				
				}
			};
		
			BScroll(option);

		});
	}

	$ct.find('.wa-vdtv-selector').on("change",function(){
		getVlink(this.value,function(xhr, errorType, error){
			console.log(errorTyp,error);
		});
	});

});

</script>
{%/strip%}{%/block%}

