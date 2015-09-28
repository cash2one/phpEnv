{%extends "search/searchaladdin/c_base/iphone.tpl"%}

{%block name="data_modifier"%}
    {%$tplData.showLeftText = "开发平台"%}
    {%$tplData.url="http://m.baidu.com"%}
    {%$tplData.title="我的标题文案"%}
	{%$tplData.len = 5%}
{%/block%}

{%block name="content"%}{%strip%}
    <style>
	.wa-tujie-scrollor{
		overflow:hidden;
		position:relative;
	}

	.wa-tujie-scrollor ul{
		width: 100%;
		height:147px;
		position:relative;
	}
	.wa-tujie-scrollor li{
		width: 100%;
		height:147px;
		display:inline-block;
		position:absolute;
		top:0;
		left:0;
	}

	.wa-tujie-scrollor li:nth-of-type(1){
		background-color:red;
	}
	.wa-tujie-scrollor li:nth-of-type(2){
		background-color:blue;
	}
	.wa-tujie-scrollor li:nth-of-type(3){
		background-color:yellow;
	}
	.wa-tujie-scrollor li:nth-of-type(4){
		background-color:#333;
		border:#444;
	}
	.wa-tujie-scrollor li:nth-of-type(5){
		background-color:#324333;
	}
	.wa-tujie-scrollor li:nth-of-type(6){
		background-color:red;
	}
	.wa-tujie-info{
		position:absolute;
		width:100%;
		bottom:0;
		right:0;
		background-color:rgba(0,0,0,0.6);
		height:27px;
		line-height:27px;
	}
	.wa-tujie-info div{
		display:inline-block;	
	}
	.wa-tujie-dots{
		position:absolute;
		right:0;
		bottom:0;
		margin-right:9px;
	}
	.wa-tujie-info .wa-tujie-dots-focus{
		background-color:#dddfdf;
	}
	.wa-tujie-info li{
		display:inline-block;
		-webkit-border-radius:50%;
		border-radius:50%;
		background-color:#9d9692;
		margin-right:7px;
		width:6px;
		height:6px;
	}
	.wa-tujie-text{
		color:#fff;
		margin-left:20px;
	}

	.wa-tujie-s-left{
		transition:all ease-out  0.1s;
		transform: translate(-100%, 0px) translateZ(0px);
	}
	.wa-tujie-s-on{
		transition:all ease-out 0.1s;
		transform: translate(0px, 0px) translateZ(0px);
	}
	.wa-tujie-s-right{
		transition:all ease-out 0.1s;
		transform: translate(100%, 0px) translateZ(0px);
	}

	</style>
	<div class="c-gap-top wa-tujie-wrapper c-row-tile WA_LOG_GES">
		<div class="wa-tujie-scrollor">
			<ul>
				<li data-index="1"></li>
				<li data-index="2"></li>
				<li data-index="3"></li>
				<li data-index="4"></li>
				<li data-index="5"></li>
			</ul>
		</div>
		<div class="wa-tujie-info">
			<div class="wa-tujie-text c-line-clamp1">花千骨</div>
			<div class="wa-tujie-dots">
				<li class="wa-tujie-dots-focus"></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
			</div>
		</div>
	</div>

	<div class="c-row c-gap-top">
		<div class="c-span8 c-color-gray-a">
			<p>主演霍建华</p>
			<p>类型：仙侠，古装</p>	
		</div>
		<div class="c-span4">
			{%fe_fn_c_box_adaptive_prefix url= $tplData.btnUrl class="c-blocka" %}
				<div class="c-btn WA_LOG_BTN c-gap-top-small">观看图文</div>
			{%fe_fn_c_box_adaptive_suffix url= $tplData.btnUrl %}	
		</div>
	</div>

	</script>
<script data-merge>
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
						_config[key] = config[key] === "undefined" ?  _config[key] : config[key]
					};
					
					for(var key in _config){
						this[key] = _config[key];
					};

					this.index = this.len - 1;
					this.lis = $(this.scrollElements).get();
					this.next();
				},
				changeQueen:function(){
					this.realIndex = this.countRealIndex();
					if(this.realIndex == 0){
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
			}
	})(window,undefined,$);

	app.init({self:this,during:2000,len:5,scrollElements:'.wa-tujie-scrollor ul li'});
	
</script>
{%/strip%}{%/block%}

