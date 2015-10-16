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
