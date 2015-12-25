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
