{%extends "search/searchaladdin/c_base/iphone.tpl"%}

{%block name="data_modifier"%}
	{%if $tplData && !$tplData.result[0]%}
		{%$tplData.result  = [$tplData.result[0]]%}
	{%/if%}

    {%$tplData.defaultUrl = 'http://m.fang.com/esf/'%}
    {%$tplData.url = $tplData.defaultUrl%}
    {%$tplData.title= $tplData.result[0].title%}
	{%$r1 = $tplData.result[0]%}

	{%$tplData.showLeftText = $tplData.result[0].from%}
	{%$tplData.showRightUrl = $tplData.result[0].site%}

	{%*显示小于等于9条信息*%}
	{%if $tplData.resNum > 9%}
		{%$size = 9%}
		{%$res = array_slice($tplData.result,0,$size)%}
	{%else%}
		{%$size = $tplData.resNum%}
		{%$res = $tplData.result%}
	{%/if%}

	{%$page = ceil($size / 3) %}

	{%*精确定位筛选信息,用户query中的筛选信息*%}
	{%$parse = []%}
	{%foreach $tplData.queryparser as $item%}
		{%foreach $item as $key=>$value%}
			{%$parse[$key] = $value%}	
		{%/foreach%}
	{%/foreach%}

	{%*url筛选信息拼接*%}
	{%if $parse['area']%}
		{%*{%$tplData.url = substr($tplData.url,0,strrpos($tplData.url,"/",-2))|cat:"/"|cat:$r1['rule_area']|cat:"/" %}	*%}
        {%$tplData.url = $tplData.url|cat:$r1['rule_area']|cat:"/"%}
    {%else%}
        {%$tplData.url = $tplData.url|cat:$r1['rule_city']|cat:"/"%}
	{%/if%}
	{%if $parse['price']%}
		{%$tplData.url = $tplData.url|cat:$r1['rule_price'] %}	
	{%/if%}
	{%if $parse['structure']%}
		{%$tplData.url = $tplData.url|cat:$r1['rule_structure'] %}	
	{%/if%}


{%/block%}

{%block name="title"%}
	{%fe_fn_c_box_adaptive_prefix url=$tplData.url ltj="title" class="c-blocka wa-shhouse-title"%}
	{%fe_fn_c_title%}
	{%fe_fn_c_box_adaptive_suffix url=$tplData.url%}
{%/block%}

{%block name="foot"%}
<div class="c-row">
    <div class="c-span4">
        <span class="c-color-gray">{%$tplData.showLeftText|escape%}</span>
        <span class="c-foot-icon c-foot-icon-16 c-foot-icon-16-aladdin c-gap-left-small"></span>
    </div>
    
    {%fe_fn_c_box_adaptive_prefix url=$tplData.url ltj="l" class="c-span8 c-blocka c-moreinfo wa-shhouse-more"%}
    {%if $tplData.showRightUrl%}
        {%$tplData.showRightText|escape%}<i class="c-icon">&#xe734</i>
    {%/if%}    
    {%fe_fn_c_box_adaptive_suffix url=$tplData.url%}
</div>

<form class="wa_shhouse_form" style="display:none;" action="//m.baidu.com/pub/search/form_proxy_enc_v2.php" method="get">
    <input type="hidden" name="w" value="{%$reqData.pn|escape%}_{%$reqData.rn|escape%}_{%$reqData.word|escape%}"/>
    <input type="hidden" name="t" value="{%$pageData.abct|escape%}"/>
    {%if $alaData.config.l%}<input type="hidden" name="l" value="{%$alaData.config.l|escape%}"/>{%/if%}
    <input type="hidden" name="ref" value="{%$pageData.pageRef|escape%}"/>
    <input type="hidden" name="ssid" value="{%$reqData.ssid|escape%}"/>
    <input type="hidden" name="uid" value="{%$reqData.uid|escape%}"/>
    <input type="hidden" name="pu" value="{%$reqData.pu|escape%}"/>
    <input type="hidden" name="bd_page_type" value="{%$reqData.bd_page_type|escape%}"/>
    <input type="hidden" name="from" value="{%$reqData.from|escape%}"/>            
    <input type="hidden" name="lid" value="{%$reqData.lid|escape%}"/>            
    <input type="hidden" name="order" value="{%$alaData.iteration|escape%}"/>
	<input type="hidden" name="fm" value="alop"/>
    <input type="hidden" name="tj" value="{%$alaData.enresourceid%}_{%$alaData.iteration%}_{%$reqData.pn%}_{%$reqData.rn%}_f{%$fe_var_form_index%}"/>
    {%if $fe_var_waplogo%}<input type="hidden" name="waplogo" value="1"/>{%/if%}
    <input type="hidden" name="src" class="wa_shhouse_fm_src" value="{%$tplData.url|escape%}{%if $tplData.url|@strpos:"?"%}{%else%}?{%/if%}"/>
    <input type="hidden" name="EncStr" class="wa_shhouse_fm_enc_str" value='{%$tplData.url|cat:"B@1duW1se"|md5|truncate:6:"":true%}'/>
    <input type="hidden" name="utf82gbk" value="1"/> 
    <input type="submit" value="{%$tplData.showRightText|escape%}" class="wa_lvyouroute_submit"/>
</form>

{%/block%}



{%block name="content"%}{%strip%}
<style>
.wa-shhouse-gap{
	margin-left:10px;
}
.wa-shhouse-nb{
	font-size:18px;
	font-weight:bold;
}
.wa-shhouse-filter-price{
}
.wa-shhouse-gap2{
	margin-left:10px;
}
.wa-shhouse-price{
}

.wa-shhouse-scrollor{
	width:{%$page%}00%;
	white-space: nowrap;
}

.wa-shhouse-scrollor li{
	width:{%1/$page*100%}%;
	display:inline-block;
	vertical-align: top;
	position: relative;
	left:2px;
}
.wa-shhouse-scrollor .c-line-bottom:last-of-type{
	border:none;
}

.wa-shhouse-scroll-wrapper{
	width:100%;
	overflow: hidden;
	position: relative;
}
</style>


<div class="c-row c-gap-top wa-shhouse-select">

	{%$desc = []%}
	{%$desc.area = '区域'%}
	{%$desc.price = '价格'%}
	{%$desc.structure = '户型'%}
	{%foreach $desc as $key => $value%}
		<div class="c-span4">
			<div class="c-dropdown">
				<select class="wa-shhouse-filter-{%$key%} WA_LOG_TAB">
					<option value="all">{%$value%}</option>
					{%if $parse[$key]%}
					<option selected="selected" >{%$parse[$key]%}</option>
					{%/if%}
				</select>
			</div>
		</div>
	{%/foreach%}
</div>


	<div class="c-scroll-wrapper wa-shhouse-scroll-wrapper">
		<ul class="wa-shhouse-scrollor">

				{%foreach $res as $item%}

					{%if $item@index % 3 == 0%}
						<li class="wa-shhouse-entity">
					{%/if%}
						{%fe_fn_c_box_adaptive_prefix url=$item.list.url class="c-blocka" %}
						<div class="c-line-bottom">
							<div class="c-row c-gap-bottom c-gap-top">
								<div class="c-span3">
									{%fe_fn_c_img_delay imgsrc={%$item.list.imgurl%}%}
								</div>
								<div class="c-span9">
									<div class="c-color-link c-line-clamp1">{%$item.list.title%}</div>
									
									<div class="c-abstract">
										<span> {%$item.list.area%}</span><span class="wa-shhouse-gap">{%$item.list.place%}</span>
									</div>

									<div class="c-abstract c-flexbox">
										<div  style="-webkit-box-flex:1;" class="c-line-clamp1">
											{%if $item.list.structure%}
												<span>{%$item.list.structure%}</span>
											{%/if%}

											{%if $item.list.size%}
												<span class="wa-shhouse-gap">{%$item.list.size%}</span>
											{%/if%}

											{%if $item.list.direction%}
												<span class="wa-shhouse-gap">{%$item.list.direction%}</span>
											{%/if%}
										</div>
										{%$price = preg_replace("/\D/","",$item.list.price)%}
										<div style="white-space: nowrap;color:#ff6600;"><span class="wa-shhouse-nb">{%$price%}</span>万</div>
									</div>

									<div class="">
										{%$tag = $item.list.tag%}
										{%if $tag && !$tag[0]%}
											{%$tag = [$tag]%}
										{%/if%}
										{%foreach $tag as $item2%}
											<span class="c-text-box c-text-box-blue {%if !$item2@first%} wa-shhouse-gap2{%/if%}">{%$item2%}</span>
										{%/foreach%}
									</div>

								</div>

							</div>
						</div>
						{%fe_fn_c_box_adaptive_suffix url=$item.list.url %}

					{%if $item@index % 3 ==2 %}
						</li>
					{%/if%}
				{%/foreach%}
		</ul>
	</div>
	<div class="" style="text-align:center;">
		<div class="c-scroll-indicator wa-shhouse-scroll-indicator">
			{%for $index=1 to $page%}
				<span {%if $index == 1%} class="c-scroll-dotty-now" {%/if%}></span>
			{%/for%}
		</div>
	</div>

<script>
	A.setup({
		"info_api":'{%"http://opendata.baidu.com/api.php?resource_id={%$tplData.resourceid%}&format=json&ie=utf-8&oe=utf-8&dsp=iphone&tn=wisexmlnew&need_di=1&query="|getHttpsHost%}',
		"parse":'{%json_encode($parse)%}',
		"city":'{%$tplData.result[0].city%}',
		"pref":'{%$fe_var_tc_jump%}',
        "titleUrl":'{%$tplData.defaultUrl%}'
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
		parse = JSON.parse(self.data.parse) || {},
		city = this.data.city || '',
        titleUrl = this.data.titleUrl || '',
		tc = new tc_jump(this.data.pref);

	require(['uiamd/iscroll/bdscroll'], function (IScroll){
		var shhouseScroll = new IScroll('.wa-shhouse-scroll-wrapper', {
			disableMouse: true,
			scrollX: true,
			scrollY: false,
			momentum:false,
			eventPassthrough : true,
			scrollbars: false,
			snap:true
		});

		shhouseScroll.on('scrollEnd', function(){
			var thisPage = this.currentPage.pageX;
			$('.wa-shhouse-scroll-indicator span').removeClass('c-scroll-dotty-now').eq(thisPage).addClass('c-scroll-dotty-now');
		});

		add_evt(shhouseScroll);

		$('body').one('onlyshowMore', function () {
			setTimeout(function() {
				shhouseScroll.refresh();
			}, 0);
		});
	});


	function getData(query,success,fail){
		var url =  self.data.info_api + encodeURIComponent(query + '二手房');
		$.ajax({
			url:url,
			jsonp:"cb",
			dataType:"jsonp"
		}).done(success).fail(fail);
	}

	function build_html(data){

		/*显示小于9条信息*/
		if( Object.prototype.toString.call(data.result) !== '[object Array]' && typeof data.result === "object"){
			data.result = [data.result];
		}
		
		var size,res,page;
		if( data.resNum > 9){
			 size = 9;
			 res = data.result.slice(0,size);
		}else{
			 size = data.resNum;
			 res = data.result;
		}

		page = Math.ceil(size/3);

		$ct.find('.wa-shhouse-scrollor').css({
			"width": (page * 100) + "%"
		});

		var p = '';

		for(var i = 0,len = size ; i < len ; i++){
			var item = res[i];	
			
			if( i % 3 == 0){
				p += '<li style="width:'+ 1/page*100 +'%;" class="wa-shhouse-entity">';
			}

			p += '<a href="'+ tc.getUrl(item.sec,item.di,item.list.url) +'" class="c-blocka"><div class="c-line-bottom">' +
					'<div class="c-row c-gap-bottom c-gap-top">' +
						'<div class="c-span3">'+
							'<div class="c-img c-img-s">'+
								'<img src="' + item.list.imgurl + '">'+
							'</div>'+
						'</div>'+
						'<div class="c-span9">'+
							'<div class="c-color-link c-line-clamp1">' + item.list.title + '</div>'+
							
							'<div class="c-abstract">'+
								'<span>' + item.list.area +'</span><span class="wa-shhouse-gap">' + item.list.place +'</span>'+
							'</div>'+

							'<div class="c-abstract c-flexbox">'+
								'<div  style="-webkit-box-flex:1;" class="c-line-clamp1">';
									if( item.list.structure){
										p += '<span>' + item.list.structure +'</span>';
									}

									if (item.list.size){
										p += '<span class="wa-shhouse-gap">'+ item.list.size +'</span>';
									}

									if (item.list.direction){
										p += '<span class="wa-shhouse-gap">' + item.list.direction +'</span>';
									}
								p += '</div>';
								var price = item.list.price.replace(/\D/,"");
								p += '<div style="white-space: nowrap;color:#ff6600;"><span class="wa-shhouse-nb">' + price +'</span>万</div>'+
							'</div>'+

							'<div class="">';
							
							/*插入tag*/
								var tag = item.list.tag;
								if(typeof tag === "string" && tag != ""){
									var temp = {};
									temp[0] = tag;
									tag = temp;
								}

								if(typeof tag == "object"){
									for(var j in tag){
										if( j  === "sec"){continue;}
										var item2 = tag[j];
										p += '<span class="c-text-box c-text-box-blue';
											if( j!=0){
												p += ' wa-shhouse-gap2';
											}
										p += '">' + item2 + '</span>';
									}
								}
							p += '</div>';

						p += '</div>';

					p += '</div>';
				p += '</div></a>';

				if( i % 3 == 2){
					p += '</li>';
				}
			}

			var dot = '';
			if(page > 1){
				for( var i=0 ; i<page;i++){
					dot += '<span';
					if( i === 0 ){
						dot += ' class="c-scroll-dotty-now"'; 
					}
					dot +=  '></span>';
				}
				$ct.find('.wa-shhouse-scroll-indicator').html(dot).show();
			}

			return p;
	}

	function add_sx(info){
		var data = JSON.parse(info);
		var sx =  ['area','price','structure'];
		var desc = {
			'area':"区域",
			'price':"价格",
			'structure':"户型"
		};

		for(var i = 0; i < sx.length ; i++){
			var p = '<option value="">'+ desc[sx[i]]  +'</option>' ;
			var info = data[sx[i]];
			for(var j = 0 ,len = info.length ; j < len ; j++){
                /*su小于30的过滤掉*/
                if(info[j].su < 30 ) continue;
				var sa = info[j].sa;
				if(sa === parse[sx[i]]){
					p += '<option selected="selected" value="'+ sa  +'">' + sa + '</option>';
				}else{
					p += '<option value="'+ sa  +'">' + sa + '</option>';
				}
			}
			$ct.find('.wa-shhouse-filter-' + sx[i]).html(p);
		}

	}


	/*切换筛选项后,切换url*/
	function changeUrl(city_tag,area_tag,price_tag,structure_tag,sec,di){
		var url = titleUrl,
			choose_area = $ct.find('.wa-shhouse-filter-area').val() ? true : false,
			choose_price = $ct.find('.wa-shhouse-filter-price').val() ? true : false,
			choose_structre = $ct.find('.wa-shhouse-filter-structure').val() ? true : false;

		if(choose_area && area_tag){
			/*url = url.substring(0,url.lastIndexOf("/",url.length -2 ) + 1) +  area_tag.trim() + "/";*/
            url += area_tag.trim() + "/";
		}else{
           url += city_tag.trim();
        }

		if(choose_price && price_tag){
			url +=  price_tag.trim();
		}

		if(choose_structre && structure_tag){
			url +=  structure_tag.trim();
		}

		/*链接md5加密,插入form*/
		/*链接如果没有参数则需要加上?*/
		$ct.find('.wa_shhouse_fm_src').val(url + "?");
		if (typeof(hexMd5) !== 'undefined') {
			var encStr = hexMd5(url + 'B@1duW1se').substr(0,6);
			$ct.find('.wa_shhouse_fm_enc_str').val(encStr);
		} else {
			A.js(location.protocol + '//m.baidu.com/static/ala/lvyouroute/md5.js?t=0915',function(){			
				var encStr = hexMd5(url + 'B@1duW1se').substr(0,6);
				$ct.find('.wa_shhouse_fm_enc_str').val(encStr);
			});
		}

	}

	function add_evt(scrollor){
		['area','price','structure'].forEach(function(el,index){
			$ct.find('.wa-shhouse-filter-' + el).on('change',function(){
				$('.wa-shhouse-scrollor').html('<div class="c-gap-top-large c-loading"> <i class="c-icon">&#xe780</i> <p>加载中…</p> </div>').css({width:"100%"});
				$('.wa-shhouse-scroll-indicator').hide();
				scrollor.refresh();	
				var query = ['area','price','structure'].reduce(function(sum,el){
					return sum + $ct.find('.wa-shhouse-filter-' + el).val();
				},'');

				query = city + query;

				getData(query,function(res){
					if( typeof res['data'][0] === 'object' && res['data'][0].resourceid){
						var str = build_html(res['data'][0]);
						$ct.find('.wa-shhouse-scrollor').html(str);
						var r1 = res['data'][0]['result'][0];
						changeUrl(r1.rule_city,r1.rule_area,r1.rule_price,r1.rule_structure,r1.sec,r1.di);
					}else{
						$ct.find('.wa-shhouse-scrollor').html('<div class="c-color-gray" style="height:120px;text-align:center;line-height:120px;">未找到相关房源,请重新选择筛选条件</div>');
					}

					setTimeout(function(){
						scrollor.refresh();	
					},0);

				});	
			});
		});

		$ct.find('.wa-shhouse-more,.wa-shhouse-title').on("click",function(){
			$ct.find('.wa_shhouse_form').submit();
			return false;
		});

	}

	(function init(){
		setTimeout(function(){
			getData(city,function(res){
                console.log(res);
				add_sx(res['data'][0].otherinfo);
			});	

		},200);
	})();

});

</script>
{%/strip%}{%/block%}

