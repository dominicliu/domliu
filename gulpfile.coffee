gulp = require 'gulp'

autoprefixer = require 'autoprefixer'
browserSync = undefined
coffee = require('gulp-coffee')
concat = require('gulp-concat')
gutil = require('gulp-util')
minifyCSS = require('gulp-minify-css')
nodemon = require('gulp-nodemon')
postcss = require 'gulp-postcss'
rename = require('gulp-rename')
sass = require 'gulp-sass'
sourcemaps = require('gulp-sourcemaps')
uglify = require('gulp-uglify')

dirs =
	js: './public/javascripts/'
	sass: "./public/stylesheets/sass/"
	css: "./public/stylesheets/css/"
	jade: './views/'

globs =
	coffee: "#{dirs.js}*.coffee"
	sass: "#{dirs.sass}style.scss"
	jade: "#{dirs.jade}*.jade"

gulp.task 'serve', ->
	nodemon
		script: 'app.coffee'
		ext: 'coffee'
		ignore: 'public'
	.on 'restart', ->
		setTimeout ->
			browserSync.reload()
		, 500

gulp.task 'coffee', ->
	gulp.src(globs.coffee)
		.pipe(sourcemaps.init())
		.pipe(coffee(bare: true).on('error', gutil.log))
		.pipe(uglify())
		.pipe rename({suffix:'.min'})
		.pipe(sourcemaps.write())
		.pipe gulp.dest(dirs.js)

compileSass = ->
	return gulp.src(globs.sass)
		.pipe(sourcemaps.init())
		.pipe sass(
			includePaths: [
				'bower_components/bootstrap-sass/assets/stylesheets/'
				'bower_components/Bootflat/bootflat/scss/'
			]
		)
		.pipe postcss([autoprefixer({ browsers: ['> 5%'] }) ])
		.pipe minifyCSS()
		.pipe rename({suffix:'.min'})
		.pipe(sourcemaps.write())
		.pipe gulp.dest(dirs.css)

gulp.task 'sass', ->
	compileSass()

gulp.task 'vendorJs', ->
	gulp.src([
		'bower_components/jquery/dist/jquery.min.js'
		'bower_components/angular/angular.min.js'
		'bower_components/angular-ui-router/release/angular-ui-router.min.js'
		'bower_components/bootstrap-sass/assets/javascripts/bootstrap.min.js'
		'bower_components/moment/min/moment.min.js'
		'bower_components/masonry/dist/masonry.pkgd.min.js'
		'bower_components/imagesloaded/imagesloaded.pkgd.min.js'
		'bower_components/angular-masonry/angular-masonry.js'
		'bower_components/angular-animate/angular-animate.min.js'
		'bower_components/velocity/velocity.min.js'
		'bower_components/velocity/velocity.ui.min.js'
		'bower_components/angular-velocity/angular-velocity.min.js'
		'javascripts/libs/lightbox/js/lightbox.min.js'
	]).pipe concat 'vendor.js'
	.pipe gulp.dest dirs.js

gulp.task 'vendorCss', ->
	gulp.src([
		'public/stylesheets/css/font-awesome.min.css'
	]).pipe concat 'vendor.css'
	.pipe gulp.dest dirs.css

gulp.task 'browser-sync-sass', ->
	compileSass().pipe browserSync.stream()

gulp.task 'browser-sync', ['serve'], ->
	browserSync = require('browser-sync').create()
	browserSync.init
		port: 3001
		proxy: "localhost:3000"
		ui:
			port: 3002

gulp.task 'watch', ['serve', 'browser-sync', 'coffee', 'sass', 'vendorJs', 'vendorCss'], ->
	gulp.watch globs.coffee, ['coffee']
		.on 'change', browserSync.reload
	gulp.watch globs.sass, ['browser-sync-sass']
	gulp.watch globs.jade, browserSync.reload

gulp.task 'build', ['coffee', 'sass', 'vendorJs', 'vendorCss']

gulp.task 'default', ['watch']