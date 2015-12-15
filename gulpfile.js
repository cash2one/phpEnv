var gulp = require("gulp"),
	replace = require("gulp-replace"),
	concat = require("gulp-concat"),
	plumber = require('gulp-plumber'),
	process = require('child_process');

gulp.task("default",function(){
	gulp.watch(["templates/*/*.php","templates/*/*.js","templates/*/*.src"],function(event){
		if(event.type == "changed"){
			var localdir = event.path.substring(0,event.path.lastIndexOf("/")),
				tplName = localdir.substring(localdir.lastIndexOf("/") + 1,localdir.length);
			var workAdress = "/Volumes/mywork/odp/",
				tplPath = workAdress + "template/search/searchaladdin/" + tplName,
				phpPath = workAdress + "app/search/library/search/searchaladdin";

			console.log(tplName,tplPath,phpPath);
			gulp.src([localdir + "/iphone.src",localdir + "/iphone.js"])
				.pipe(plumber()) //plumber给pipe打补丁,防止报错
				.pipe(concat('iphone.tpl'))
				.pipe(replace(/(MYJS)([\s\S]*)(A\.init\([\s\S]*)/,"$3$2"))
				.pipe(gulp.dest(localdir))
				.pipe(gulp.dest(tplPath));

			gulp.src([localdir + "/"+ tplName.replace("_","") + "SrcPreProcessor.php"])
				.pipe(plumber()) //plumber给pipe打补丁,防止报错
				.pipe(gulp.dest(phpPath));
		}
	});

	gulp.watch(["/Volumes/mywork/odp/log/search/search.log.wf"],function(event){
		if(event.type == "changed"){
			process.exec("tail -1 " + event.path,function(error,stdout,stderr){
				if(error !== null){
					console.log("脚本执行错误");
				}
				console.log(stdout);
			});
		}
	});
});
