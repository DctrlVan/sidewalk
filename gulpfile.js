var gulp = require('gulp');
var concat = require('gulp-concat');
var mini = require('gulp-minify-css');
gulp.task('default',function(){
	gulp.src(['node_modules/bootstrap/dist/css/bootstrap.min.css','styles/*.css'])
		.pipe(concat('bundle.css'))
		.pipe(mini())
		.pipe(gulp.dest('public'))
}
);
