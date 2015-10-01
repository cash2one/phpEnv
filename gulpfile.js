var gulp = require("gulp");
var replace = require("gulp-replace");
var concat = require("gulp-concat");

gulp.task("default",function(){
	gulp.watch(["templates/*/*.js","templates/*/*.src"],function(event){
		if(event.type == "changed"){
			var dir = event.path.substring(0,event.path.lastIndexOf("/"));		
			console.log(dir);
			gulp.src([dir + "/iphone.src",dir + "/iphone.js"])
				.pipe(concat('iphone.tpl'))
				.pipe(replace(/(MYJS)([\s\S]*)(A\.init\([\s\S]*)/,"$3$2"))
				.pipe(gulp.dest(dir));
		}
	});
});
