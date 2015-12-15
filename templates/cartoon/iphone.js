A.init(function(){

	require(['uiamd/tabs/tabs'], function (Tabs){
        var scrollTabs = new Tabs($('.wa-tabs-wrapper-scroll'), {
            allowScroll: true,
            toggleMore: false
        });
    });	

	require(['uiamd/iscroll/iscroll'], function (IScroll){
		var cartoonScroll = new IScroll('.wa-cartoon-scroll-wrapper', {
			disableMouse: true,
			scrollX: true,
			scrollY: false,
			eventPassthrough : true,
			scrollbars: false
		});

		$('body').one('onlyshowMore', function () {
			setTimeout(function() {
				cartoonScroll.refresh();
			}, 0);
		});
	});

		

	
			

});
	
