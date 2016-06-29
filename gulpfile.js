var gulp = require('gulp');
var sass = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');
var uglify = require('gulp-uglify');
var connect = require('gulp-connect');

gulp.task('fonts', function () {
    gulp.src('./bower_components/font-awesome/fonts/*.*')
    .pipe(gulp.dest('./fonts/'));
    gulp.src('./bower_components/font-awesome/css/font-awesome.min.css')
    .pipe(gulp.dest('./css/'));
});

gulp.task('scripts', function () {
    gulp.src('./bower_components/jquery/dist/jquery.min.js')
    .pipe(gulp.dest('./js/'));
});

gulp.task('sass', function() {
    gulp.src('src/sass/**/*.scss')
    .pipe(sourcemaps.init())
    .pipe(sass().on('error', sass.logError))
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('./css/'));
});

gulp.task('uglify', function () {
    gulp.src('src/js/**/*.js')
    .pipe(uglify())
    .pipe(gulp.dest('./js/'));
});

gulp.task('xsl', function() {
    gulp.src('./src/xsl/*.xsl')
    .pipe(gulp.dest('.'));
});
 
gulp.task('connect', function() {
    connect.server();
});

gulp.task('default', ['fonts', 'scripts', 'sass', 'uglify', 'xsl', 'connect'], function() {
    gulp.watch('src/sass/**/*.scss', ['sass']);
    gulp.watch('src/js/**/*.js', ['uglify']);
    gulp.watch('src/xsl/**/*.xsl', ['xsl']);
});