A.init(function(){

require(['uiamd/iscroll/iscroll'], function (IScroll){
	var scrolls = document.querySelectorAll(".wa-gcw-scroll-wrapper");
	var sols = [];

	[].slice.call(scrolls).forEach(function(el,index){
		var gcwScroll = new IScroll(el, {
			disableMouse: true,
			scrollX: true,
			scrollY: false,
			eventPassthrough : true,
			scrollbars: false
		});
		
		sols.push(gcwScroll);
	});


	$('body').one('onlyshowMore', function () {
		setTimeout(function() {
			[].slice.call(sols).forEach(function(el,index){
				el.refresh();		
			});
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
