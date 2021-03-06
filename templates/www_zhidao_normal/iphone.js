A.init(function(){
(function(window,undefined){
	
	var transition = function(selector){
		return new init(selector);
	};
	window.t = transition;

	var init = transition.prototype.init = function(selector){
		this.objs = Array.prototype.slice.call(document.querySelectorAll(selector));
		this.queue = [];
		this.cssStr = [];
		this.transform = ['','','',''];
		this.duringtime = '';
	};
	init.prototype = {
		constructor:init,
		translate:function(x,y,z){
			var str = 'translate3d('+ x +','+ y + ',' + z +')';
			this.transform[0] = str;
			return this;
		},
		
		rotate : function(angle){
			var str = 'rotate('+ angle +')'	;
			this.transform[1] = str;
			return this;
		},

		scale : function(sx,sy,sz){
			var str = 'scale3d(' + sx + ',' + sy + ',' + sz +')';
			this.transform[2] = str;
			return this;
		},


		skew:function(x,y){
			var str = 'skew(' + x + ',' + y +')';
			this.transform[3] = str;
			return this;
			
		},

		set : function(attr){
			var sum = '';
			for(var i in attr){
				sum += i + ':' + attr[i] +";";	
			}
			this.cssStr.push(sum);	
			return this;
		
		},
		
		then:function(waitting){
			if(this.duringtime === '') return;
			this.cssStr.push('transform:'+ this.transform.join(' ') +';');
			this.queue.push({
				cssText:'transition-duration:' + this.duringtime + 'ms;' + this.cssStr.join(';'),
				waitting: waitting || 0,
				during:this.duringtime
			});

			this.cssStr = [];
			this.duringtime = '';
			return this;

		},
		clear:function(){},

		during:function(duringtime){
			this.duringtime = duringtime;
			return this;
		},

		fire:function(){
			this.then();
			var action = this.queue.shift(),
				self = this;
			if(!action) return;

			this.objs.forEach(function(el,index){
				el.style.cssText += action.cssText;

			});
			setTimeout(function(){
				self.fire();
			},action.during + action.waitting);
		},
		t:function(selector){
			this.objs = Array.prototype.slice.call(document.querySelectorAll(selector));
			return this;
		}

	};

})(window,undefined);

		
	function start(){
	
	}

	var ct = this.container;
	var pos = $(this.container).offset();
	var pos2 = $(this.container).offset();
	var width = $(window).width();
	var height = $(window).height();
	var scale_x = width / pos.width;
	var scale_y = 326 / 116;
	var origin_x = ( pos.width / 2 ) +'px';
	var origin_y = '75px';


	$('.show').on('click',function(){
		var top = ct.offsetTop - document.body.scrollTop;
		var str = '<div id="mark" style="z-index:100;transform-origin:0 0;opacity:0;margin-left:0;margin-top:0;position:fixed;background-color:#fff;top:'+ top + "px;left:"+ ct.offsetLeft + "px;width:"+ pos.width + "px;height:" + pos.height + 'px;"><div id="color-s" style="background-color:#9F6B40;height:116px;"></div></div>';
		$(str).appendTo('body');

			setTimeout(function(){
				t('#mark').set({
					opacity:1
				}).during(200).then()
				.scale(scale_x,1,1)
				.translate((-1 * (width - pos.width)/2) + "px",0,0).during(150).then()
				.scale(scale_x,scale_y,1)
				.translate((-1 * (width - pos.width)/2) + "px",(-1 * ( ct.offsetTop - document.body.scrollTop ) ) +"px",0).during(300).fire();
			
			},0);

			setTimeout(function(){
				$('body').append('<div id="center" style="z-index:1000;width:100%;margin-left:0;margin-top:0;position:absolute;background-color:#fff;top:0;left:0px;"><div class="center-bar" style="position:fixed;top:0;left:0;transform:translate3d(0,-56px,0);background-color:red;height:56px;width:100%;"><div style="position:absolute;right:15px;" class="center-close">x</div></div><div id="color-s" style="background-color:#9F6B40;height:326px;"></div><div style="height:436px;"><div class="center-content" style="opacity:0;transform:translate3d(0,20px,0);"><div>方式</div>将法律的教室里房间里的设计<div>费李经理</div>说减肥了到家了分离<div>式的房间里是减肥了鲁大师</div></div></div>');
				document.body.scrollTop = 0;
			},750);


			setTimeout(function(){
				t('.center-bar').set({
				}).translate(0,0,0).during(150).fire();
			},800);
			

			setTimeout(function(){
				t('.center-content').set({
					opacity:1,
				}).translate(0,0,0).during(250).fire();
			},850);



			setTimeout(function(){
				$('#page').hide();		
				$('#mark').remove();		
				$('.center-close').on('touchstart',function(){
					$('#center').remove();
					$('#page').show();
				});
			},1100)

	});

});

