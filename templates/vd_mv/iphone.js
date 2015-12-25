A.init(function(){
	require(['uiamd/tabs/tabs'], function (Tabs){
		var fixedTabs = new Tabs($('.wa-vd-mv-wrap'), {
			allowScroll: true
		});
	});
});
