A.init(function(){
        A.init(function () {
            var self = this;
            var init = function () {
                require([
                    'uiamd/iscroll/iscroll'
                ], function (IScroll) {
                    new IScroll('.wa-vd-variety-scroll-wrapper', {
                        disableMouse: true,
                        scrollX: true,
                        scrollY: false,
                        eventPassthrough: true,
                        scrollbars: false

                    });
                });
            };
            $(self.container).on('onlyshowMore', init);
            A.onload(init);
        });
});
