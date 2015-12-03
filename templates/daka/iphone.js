A.init(function(){
	
var tplRender = function(data,tplStr){
	var str = tplStr.replace(/<%=(.*?)%>/g,"');p.push($1);p.push('")
			.replace(/<%/g,"');")
			.replace(/%>/g,"p.push('");
	str = "var p = [];p.push('" + str + "');return p.join('');" ;
	var fn =  new  Function("data",str);
	return fn(data);
};

var sstr = tplRender([
	{"name":"fdsf"},
	{"name":"xxxxx"}
],document.querySelector(".tpl").innerHTML);

console.log(sstr);
alert(sstr);

});
