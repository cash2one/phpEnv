A.init(function(){
	require(['uiamd/tabs/tabs'], function (Tabs){
		var fixedTabs = new Tabs($('.wa-single-variety-wrap'), {
			allowScroll: true
		});
	});
});
