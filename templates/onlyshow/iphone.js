A.init(function(){

var $ct = $(this.container);

require(['uiamd/tabs/tabs'], function (Tabs){
		var scrollTabs = new Tabs($ct.find('.wa-shortvideo-wrapper-scroll'), {
			allowScroll: true,
			toggleMore: false,
			onChange:function(){
				sols[this.current].refresh();
			}
		});
});	
var sols = [];

require(['uiamd/iscroll/iscroll'], function (IScroll){
	var scrolls = [].slice.call(document.querySelectorAll(".wa-shortvideo-scroll-wrapper"));

	scrolls.forEach(function(el,index){
		var shortvideoScroll = new IScroll(el, {
			disableMouse: true,
			scrollX: true,
			scrollY: false,
			eventPassthrough : true,
			scrollbars: false
		});

		sols.push(shortvideoScroll);
	});

	$('body').one('onlyshowMore', function () {
		setTimeout(function() {
			sols.forEach(function(el,index){
				el.refresh();		
			});
		}, 0);
	});

});




});
