{%extends "search/searchaladdin/c_base/iphone.tpl"%}

{%block name="data_modifier"%}
    {%$tplData.url="http://m.baidu.com"%}
{%/block%}

{%block name="content"%}{%strip%}
<style>
@-webkit-keyframes upbtn{
	0%{-webkit-transform:translateY(0px);opacity:0}
	50%{-webkit-transform:translateY(-5px);opacity:1}
	100%{-webkit-transform:translateY(-10px);opacity:0}
}

.scence{
	width:100%;
	height:100%;
	position: absolute;
	top:0;
	left:0;
	background-size:cover;
	-webkit-backface-visibility:hidden;
	-webkit-transform:translate3d(0,100%,0);
	-webkit-perspective:100;

}

.s1{
	background-image:url('http://activecdn.fruitday.com/sale/orange1117/images/photo/1.jpg');
}
.s2{
	background-image:url('http://activecdn.fruitday.com/sale/orange1117/images/photo/2.jpg');
}
.s3{
	background-image:url('http://activecdn.fruitday.com/sale/orange1117/images/photo/3.jpg');
}
.s4{
	background-image:url('http://activecdn.fruitday.com/sale/orange1117/images/photo/4.jpg');
}
</style>

<div class="scence s1" style="-webkit-transfrom:translate3d(0,0,0);"></div>
<div class="scence s2"></div>
<div class="scence s3"></div>
<div class="scence s4"></div>

<script data-merge>
A.init(function(){
	
});

</script>
{%/strip%}{%/block%}

