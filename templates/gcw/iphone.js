A.init(function(){

var ct = $(this.container),self = this;

require(['uiamd/iscroll/iscroll'], function (IScroll){
	var gcwScroll = new IScroll('.wa-gcw-scroll-wrapper', {
		disableMouse     : true,
		scrollX          : true,
		scrollY          : false,
		eventPassthrough : true,
		scrollbars       : false,
		snap             : true
	});

	gcwScroll.on('scrollEnd', function(){
		var thisPage = this.currentPage.pageX;
		var tabindex = self.data.hook[thisPage] + "";
		if( tabindex != "undefined" && tabindex !== ""){
			console.log(thisPage);
			ct.find('.wa-gcw-tabs li').removeClass('c-tabs-nav-selected').eq(tabindex).addClass('c-tabs-nav-selected');
		}
		$('.wa-gcw-scroll-indicator span').removeClass('c-scroll-dotty-now').eq(thisPage).addClass('c-scroll-dotty-now');
	});

	var	lis = ct.find('.wa-gcw-tabs li').on("click",function(){
		$(this).addClass('c-tabs-nav-selected').siblings().removeClass('c-tabs-nav-selected');
		for(var key in self.data.hook){
			if(self.data.hook[key] == $(this).index()){
				gcwScroll.goToPage(key,0,800);
			}
		}
 	}); 

	$('body').one('onlyshowMore', function () {
		setTimeout(function() {
			gcwScroll.refresh();
		}, 0);
	});
});
});
