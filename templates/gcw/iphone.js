A.init(function(){

var ct = $(this.container),self = this;

require(['uiamd/iscroll/iscroll'], function (IScroll){
	var gcwScroll = new IScroll('.wa-gcw-scroll-wrapper', {
		disableMouse: true,
		scrollX: true,
		scrollY: false,
		eventPassthrough : true,
		scrollbars: false
	});


	$('body').one('onlyshowMore', function () {
		setTimeout(function() {
			gcwScroll.refresh();
		}, 0);
	});
});


require(['uiamd/tabs/tabs'], function (Tabs){
		var scrollTabs = new Tabs($('.wa-gcw-wrapper-scroll'), {
			allowScroll: true,
			toggleMore: false
		});
});	

});
