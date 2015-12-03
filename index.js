var http = require("http");
var middleware = require('node-phpcgi')({
    documentRoot: __dirname,
    // change it to your own handler path
    handler: '/usr/bin/php'
});

var app = http.createServer(function(req, res) {

	var phpcig = middleware(req, res, function(pathname,search) {
	
		return {
			"name":"fds"
		};
	});
});

app.listen(9000);
