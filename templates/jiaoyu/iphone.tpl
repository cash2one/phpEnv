{%extends "search/searchaladdin/c_base/iphone.tpl"%}

{%block name="data_modifier"%}
    {%$tplData._alaFm="alwz"%}
    {%$tplData.showLeftText = "开发平台"%}
    {%$tplData.showRightUrl = "http://www.baidu.com/"%}
    {%$tplData.showRightText = "查看更多相关结果"%}
    {%$tplData.url="http://m.baidu.com"%}
    {%$tplData.title="我的标题文案"%}
    {%$tplData.len = 8 %}
	{%$tplData.hook = array("","","","","")%}
	{%$tplData.list = array( array("","",""),array("",""),array("","",""))%}


	{%$tplData.height = '150'%}
{%/block%}

{%block name="content"%}{%strip%}
<style>
	#wa-jiaoyu-canvas{
		width:100%;
		height: {%$tplData.height|cat:"px"%};

	}
	.wa-jiaoyu-wrap{
		position: relative;
	}
	.wa-jiaoyu-canvas-wrap{
		height: {%$tplData.height|cat:"px"%};
		margin-bottom:8px;
	}
	.money{
		font-weight: bold;
		font-size:20px;
	}
	.wa-jiaoyu-info{
		text-align: center;
		margin: 16px 0 25px 0;
	}
	.wa-jiaoyu-dot-red,.wa-jiaoyu-dot-blue{
		width:12px;
		height:12px;
		border-radius:50%;
		display:inline-block;
		margin-right:5px;
		position: relative;
		top:1px;
	}
	.wa-jiaoyu-dot-red{
		background-color:#ff6600;
	}
	.wa-jiaoyu-dot-blue{
		background-color:#1f91ff;
	}
	.wa-jiaoyu-hy{
		display:inline-block;
		margin-left:5px;
	}
</style>

	<div class="c-tabs c-gap-top wa-jiaoyu-wrapper-fixed" >
		<div class="c-row-tile">
			<ul class="c-tabs-nav">
				<li class="c-tabs-nav-li WA_LOG_TAB c-tabs-nav-selected" data-tid="0">第一季
				</li><li class="c-tabs-nav-li WA_LOG_TAB" data-tid="1">第二季
				</li><li class="c-tabs-nav-li WA_LOG_TAB" data-tid="2">第三季
				</li>
			</ul>
		</div>
		<div class="c-tabs-content">
			<div class="c-row wa-jiaoyu-info">
				<div class="c-span4">
					<p>应届平均工资</p>
					<p class="money">￥5678</p>
				</div>
				<div class="c-span4 info">
					<p>应届平均工资</p>
					<p class="money">￥5678</p>
				</div>
				<div class="c-span4 info">
					<p>应届平均工资</p>
					<p class="money">￥5678</p>
				</div>
			</div>	
			<div class="c-row c-color-gray">
				<div class="c-span5">
					<span>平均薪资走势图(元)</span>
				</div>
				<div class="c-span7">
					<span><span class="wa-jiaoyu-dot-red"></span >该专业毕业生</span>
					<span class="c-gap-left-small"><span class="wa-jiaoyu-dot-blue"></span>全国业毕业生</span>
				</div>
			</div>
			<div class="c-row c-gap-top-large">
				<div class="c-span12 wa-jiaoyu-canvas-wrap">
					<canvas id="wa-jiaoyu-canvas"></canvas>
				</div>
			</div>
		</div>
		<div class="c-tabs-content" style="display: none;">
			{%foreach $tplData.hook as $item%}
				<div class="wa-jiaoyu-row  c-gap-top-large">
					<div class="c-row">
						<div class="c-span9">
						<span> {%if $item@iteration < 10%} 0{%$item@iteration%} {%else%} {%$item@iteration%} {%/if%}</span>
							<span class="wa-jiaoyu-hy">金融/投资<span>
						</div>
						<div class="c-span3" style="text-align: right;"> 32% </div>
					</div>
					<div class="c-gap-top-small" style="height:4px;width:100%;background-color: #81d5ff"></div>
				</div>
			{%/foreach%}

			<div class="c-gap-top c-gap-bottom-small c-line-clamp3">
				发动机是浪费就领导是解放军的快速减肥了看电视剧防雷接地说了句疯狂倒计时了福建代理商交付了解到了师傅家连锁店将发动机富士康
			</div>
		</div>
		<div class="c-tabs-content" style="display: none;">第三季内容</div>
		<div class="c-tabs-content" style="display: none;">第四季内容</div>
	</div>

	

<script>
A.setup({
	len : 5,
	hook: {%$tplData.hook|json_encode%}
});
</script>
    

<script data-merge>
A.init(function(){
	var canvas = document.querySelector("#wa-jiaoyu-canvas");
	ctx = canvas.getContext("2d");

	var cfg = {
		xUnit:1,
		yUnit:5000,
		xlen:5,
		unitHeight:38,
		unitWidth:50,
		startX:30,
		tScale: window.devicePixelRatio,
		offsetAxis:{
			x:40,
			y:40
		},
		lineWidth:1,
		fontPaddingRight:10,
		nbPaddingtop:15,
		kefduHeight:2,
		fontSize:14,
		pointR : 3,
		points:[[
			{
				x:0,
				y:3999
			},
			{
				x:1,
				y:4782
			},
			{
				x:2,
				y:7000
			},
			{
				x:3,
				y:8888
			},
			{
				x:4,
				y:13239
			},
			{
				x:5,
				y:15000
			}
		],[
			{
				x:0,
				y:2999
			},
			{
				x:1,
				y:3782
			},
			{
				x:2,
				y:6000
			},
			{
				x:3,
				y:7888
			},
			{
				x:4,
				y:10239
			},
			{
				x:5,
				y:14000
			}
		]]

	};

	(function init(){
		tabSetup();
		canvasSetup();
		drawTable();

		/*lin1*/
		ctx.strokeStyle = "#ff6600";
		ctx.fillStyle = "#ff6600"; 
		drawLine(cfg.points[0]);
		/*lin2*/
		ctx.strokeStyle = "#1f91ff";
		ctx.fillStyle = "#1f91ff"; 
		drawLine(cfg.points[1]);
	})();

	function tabSetup(){
		require(['uiamd/tabs/tabs'], function (Tabs){
			var fixedTabs = new Tabs($('.wa-jiaoyu-wrapper-fixed'), {});
		});	
	
	}

	function canvasSetup(){

		canvas.width = scale(canvas.offsetWidth);
		canvas.height = scale(canvas.offsetHeight);
		["nbPaddingtop","kefduHeight","pointR","unitHeight","startX","fontSize","fontPaddingRight"].forEach(function(el,index){
			cfg[el] = scale(cfg[el]);
		});
		cfg.unitWidth = ( canvas.width - 2 * cfg.startX ) / cfg.xlen;

		ctx.translate(scale(47),canvas.height - scale(23));		
		ctx.textAlign = "end";
		ctx.textBaseline = "middle";
		ctx.font = cfg.fontSize + "px" + " Arial, Helvetica, sans-serif lighter";
		ctx.lineWidth = scale(cfg.lineWidth);
	} 

	function scale(value){
		return value * cfg.tScale;	
	}

	function getPosition(item){
		var x = item.x * cfg.unitWidth + cfg.startX;
		var y = getXY(item.y * cfg.unitHeight / cfg.yUnit) ;
		return {
			x:x,
			y:y
		};
	}

	function getXY(x){
		return 	(-1) * (x + 1);
	}
	function drawTable(){
		/*画表格线*/
		ctx.strokeStyle = "#f1f1f1";
		ctx.fillStyle = "#666666";
		for(var i=0;i<4;i++){
			ctx.beginPath();
			var y = getXY( i * cfg.unitHeight);
			ctx.moveTo(0,y);
			ctx.lineTo(canvas.width,y);

			if(i !== 0){
				ctx.fillText(i * cfg.yUnit,(-1) * cfg.fontPaddingRight,y);
			}
			ctx.closePath();
			ctx.stroke();
		}
	
		/*画表头*/
		ctx.beginPath();
		ctx.moveTo(0,0);
		ctx.fillText("经验(年)",13,cfg.nbPaddingtop);
		ctx.stroke();

		/*画刻度*/
		ctx.textAlign = "center";
		cfg.points[0].forEach(function(el,index){
			ctx.beginPath();
			var pos = getPosition(el);
			ctx.moveTo(pos.x,getXY(cfg.kefduHeight + 2));
			ctx.lineTo(pos.x,cfg.kefduHeight);	

			ctx.moveTo(pos.x,pos.y);
			ctx.fillText(index,pos.x,cfg.nbPaddingtop);
			ctx.stroke();
		});
	}

	function drawLine(points){
		ctx.beginPath();
		ctx.moveTo(0,0);
		points.forEach(function(el,index){
			var pos = getPosition(el);
			ctx.lineTo(pos.x,pos.y);	
		});
		ctx.stroke();

		points.forEach(function(el,index){
			ctx.beginPath();
			var pos = getPosition(el);
			ctx.arc(pos.x, pos.y, cfg.pointR, 0, Math.PI*2, true); 
			ctx.closePath();
			ctx.fill();
		});
	}

	function drawKedu(points){
	}

	function drawTablexxx(){
		console.log(canvas.height);
		
		ctx.font = cfg.fontSize + "px" + " Arial, Helvetica, sans-serif lighter";
		ctx.fillText("经验(年)",0,-4);
		ctx.beginPath();
		ctx.closePath();
		ctx.stroke();

	}
});

</script>
{%/strip%}{%/block%}

