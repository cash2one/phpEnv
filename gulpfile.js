var gulp = require("gulp"),
	replace = require("gulp-replace"),
	concat = require("gulp-concat"),
	plumber = require('gulp-plumber');

gulp.task("default",function(){
	gulp.watch(["templates/*/*.js","templates/*/*.src"],function(event){
		if(event.type == "changed"){
			var localdir = event.path.substring(0,event.path.lastIndexOf("/")),
				tplName = localdir.substring(localdir.lastIndexOf("/") + 1,localdir.length);
			var workAdress = "/Volumes/linuxsir/odp/",
				tplPath = workAdress + "template/search/searchaladdin/" + tplName,
				phpPath = workAdress + "app/search/library/search/searchaladdin";

			console.log(tplName,tplPath);
			gulp.src([localdir + "/iphone.src",localdir + "/iphone.js"])
				.pipe(plumber()) //plumber给pipe打补丁,防止报错
				.pipe(concat('iphone.tpl'))
				.pipe(replace(/(MYJS)([\s\S]*)(A\.init\([\s\S]*)/,"$3$2"))
				.pipe(gulp.dest(localdir))
				.pipe(gulp.dest(tplPath));
		}
	});
});
