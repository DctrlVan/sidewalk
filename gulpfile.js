var gulp = require('gulp');
var sass = require('gulp-sass')
var concat = require('gulp-concat');
var mini = require('gulp-minify-css');



gulp.task('glyphicons', function(){
	gulp.src([
		'styles/glyphicons.scss'
	])
	.pipe(sass())
	.pipe(gulp.dest('styles'))
});

gulp.task('default',function(){
	gulp.src([
		'node_modules/bootstrap/dist/css/bootstrap.min.css',
		'styles/*.css',
		'templates/menuPublic/*.css'
		])
		.pipe(concat('bundle.css'))
		.pipe(mini())
		.pipe(gulp.dest('public'))
}
);
