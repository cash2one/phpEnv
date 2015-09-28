{%extends "search/searchaladdin/c_base/iphone.tpl"%}
{%block name="data_modifier"%}
{%$tplData.title="我是帅哥"%}
{%$tplData.highlight='我是'%}
{%$tplData.url=''%}
{%/block%}
	
{%block name="footer"%}
{%/block%}

{%block name="content"%}

<style>
	.aa{}
</style>

<h1 class="aa">
	this is a 测试
</h1>

<script>

var app = (function(window,undefined,$){
		/* 私有方法 */
		var _render = function(){
		
		};

		/* 初始化配置参数 */
		var _setup = function(config){
			var _config = {
				name:"alan"	
			};

			for(var key in config){
				_config[key] = config[key] === "undefined" ?  _config[key] : config[key]
			}

			return _config;
		};


		/* 构造函数*/
		var init = function(config){
			config = _setup(config);

			this.name = config.name;
			;
			
		};
		var fn = init.prototype;
		/* 外部接口 */
		fn.hello  = function(){
			alert("hello world " + this.name);	
		};
		return init;
})(window,undefined,$)

 var test = new app({name:"hahaha"});
 test.hello();
 test._setup();
</script>

{%/block%}

