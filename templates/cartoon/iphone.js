A.init(function(){
	var scrollTabs,
		$ct = $(this.container),
		scrolls = [];
	
	require(['uiamd/tabs/tabs'], function (Tabs){
		scrollTabs = new Tabs($('.wa-tabs-wrapper-scroll'), {
            allowScroll: true,
            toggleMore: false,
			onChange:function(){
				scrolls[this.current].refresh();
				$ct.find('.wa-cartoon-title-' + this.current).show().siblings("a").hide();
			}
        });
    });

	require(['uiamd/iscroll/bdscroll'], function (IScroll){
		[].slice.call(document.querySelectorAll('.wa-cartoon-scroll-wrapper')).forEach(function(el,index){
			var Scroll = new IScroll(el, {
				disableMouse: true,
				scrollX: true,
				scrollY: false,
				eventPassthrough : true,
				scrollbars: false
			});
			scrolls.push(Scroll);
		});

		$('body').one('onlyshowMore', function () {
			setTimeout(function() {
				scrolls.forEach(function(el,index){
					el.refresh();
				});
			}, 0);
		});
	});

		

	
			

});
	
