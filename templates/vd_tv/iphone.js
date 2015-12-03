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
					p += '<a href="' + item.linkurl; p += '">' + item.linkcontent ; if( item.latest ){ p += '<i style="position:absolute;top:0px; right:0px;" class="c-text-box c-text-box-red">新</i>';  }  p+='</a>';

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
						console.log(url);
						console.log(url);
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
