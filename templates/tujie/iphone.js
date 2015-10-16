A.init(function () {
	var app = (function(window,undefined,$){
			return {
				init:function(config){
					this.setup(config);
					this.bindTimer();
				},
				setup:function(config){
					var _config = {
						self : null,
						timer : null,
						during: 400,
						len : 5,
						realIndex:0,
						scrollElements:''
					};
					for(var key in config){
						_config[key] = config[key] === "undefined" ?  _config[key] : config[key];
					}
					
					for(var key in _config){
						this[key] = _config[key];
					}

					this.index = this.len - 1;
					this.lis = $(this.scrollElements).get();
					this.next();
				},
				changeQueen:function(){
					this.realIndex = this.countRealIndex();
					if(this.realIndex === 0){
						var last = this.lis.pop();
						this.lis.unshift(last);
						this.index++;
						this.realIndex++;
					}
					if(this.realIndex == this.len - 1 ){
						var first = this.lis.shift();
						this.lis.push(first);
						this.index--;
						this.realIndex --;
					}
				},
				prev:function(){
					this.index--;	 
					this.changeQueen();
					this.changePosition();
				},
				next:function(){
					this.index++;
					this.changeQueen();
					this.changePosition();
				},
					
				changePosition:function(){
					var  self = this;
					$.each(this.lis,function(index,el){
						if(index == self.realIndex){
							this.style.cssText = 'z-index:10;transition-timing-function:cubic-bezier(0.1, 0.57, 0.1, 1);transition-duration:402ms; transform: translate(0, 0px) translateZ(0px);';
						}else if (index<self.realIndex){
							this.style.cssText = 'z-index:1;transition-timing-function:cubic-bezier(0.1, 0.57, 0.1, 1);transition-duration:402ms; transform: translate(-100%, 0px) translateZ(0px);';
						}else{
							this.style.cssText = 'z-index:1;transition-timing-function:cubic-bezier(0.1, 0.57, 0.1, 1);transition-duration:402ms;  transform: translate(100%, 0px) translateZ(0px);';
						}	
					});
				},
				timerHandle:function(){
					this.next();
				},
				bindTimer:function(){
					this.timer = setInterval(this.timerHandle.bind(this),this.during);
				},
				countRealIndex:function(){
					return  this.index % this.len;
				},
				changeDot:function(){
					var ct = $(this.self.container);
					ct.find(".wa-tujie-dots li").eq(this.countRealIndex()).addClass("wa-tujie-dots-focus").siblings().removeClass("wa-tujie-dots-focus");
				}
			};
	})(window,undefined,$);

	app.init({self:this,during:2000,len:this.data.len,scrollElements:'.wa-tujie-scrollor ul li'});
});
