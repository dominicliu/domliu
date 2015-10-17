gulp = require 'gulp'

plugins = require('gulp-load-plugins')()

browserSync = undefined
open = require 'open'
Pageres = require 'pageres'
path = require 'path'

dirs =
	js: './public/javascripts/'
	sass: "./public/stylesheets/sass/"
	css: "./public/stylesheets/css/"
	screenshots: "./screenshots/"
	jade: './views/'

globs =
	coffee: "#{dirs.js}*.coffee"
	sass: "#{dirs.sass}style.scss"
	jade: "#{dirs.jade}*.jade"

gulp.task 'serve', ->
	plugins.nodemon
		script: 'app.coffee'
		ext: 'coffee'
		ignore: 'public'
	.on 'restart', ->
		setTimeout ->
			browserSync.reload()
		, 500

gulp.task 'coffee', ->
	gulp.src(globs.coffee)
		.pipe plugins.plumber()
		.pipe(plugins.sourcemaps.init())
		.pipe(plugins.coffee(bare: true).on('error', plugins.util.log))
		.pipe(plugins.uglify())
		.pipe plugins.rename({suffix:'.min'})
		.pipe(plugins.sourcemaps.write())
		.pipe gulp.dest(dirs.js)

compileSass = ->
	return gulp.src(globs.sass)
		.pipe plugins.plumber()
		.pipe(plugins.sourcemaps.init())
		.pipe plugins.sass(
			includePaths: [
				'bower_components/bootstrap-sass/assets/stylesheets/'
				'bower_components/Bootflat/bootflat/scss/'
			]
		).on('error', plugins.sass.logError)
		.pipe plugins.autoprefixer { browsers: ['> 5%'] }
		.pipe plugins.cssnano()
		.pipe plugins.rename({suffix:'.min'})
		.pipe(plugins.sourcemaps.write())
		.pipe gulp.dest(dirs.css)

gulp.task 'sass', ->
	compileSass()

gulp.task 'vendorJs', ->
	gulp.src([
		'bower_components/jquery/dist/jquery.min.js'
		'bower_components/angular/angular.min.js'
		'bower_components/angular-ui-router/release/angular-ui-router.min.js'
		'bower_components/bootstrap-sass/assets/javascripts/bootstrap.min.js'
		'bower_components/angular-bootstrap/ui-bootstrap.min.js'
		'bower_components/angular-bootstrap/ui-bootstrap-tpls.min.js'
		'bower_components/moment/min/moment.min.js'
		'bower_components/masonry/dist/masonry.pkgd.min.js'
		'bower_components/imagesloaded/imagesloaded.pkgd.min.js'
		'bower_components/angular-masonry/angular-masonry.js'
		'bower_components/angular-animate/angular-animate.min.js'
		'bower_components/headroom.js/dist/headroom.min.js'
		'bower_components/headroom.js/dist/angular.headroom.min.js'
		'bower_components/vivus/dist/vivus.min.js'
		'public/javascripts/libs/lightbox/js/lightbox.min.js'
	]).pipe plugins.concat 'vendor.js'
	.pipe gulp.dest dirs.js

gulp.task 'vendorCss', ->
	gulp.src([
		'public/stylesheets/css/font-awesome.min.css'
		'bower_components/animate.css/animate.min.css'
	]).pipe plugins.concat 'vendor.css'
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

gulp.task 'screenshots', (cb) ->
	argv = require('minimist')(process.argv.slice(2))
	url = argv.url or 'localhost:3000'
	pageres = new Pageres(delay: 3).src(url, [
		'iPhone 4'
		'iPhone 5S'
		'iPhone 6'
		'iPhone 6 Plus'
		'iPad'
		'1280x1024'
		'1366x768'
		'1920x1080'
	], {
		crop: true
		filename: '<%= size %>'
	}).dest(dirs.screenshots)
	pageres.run (err) ->
		open(path.normalize("#{dirs.screenshots}320x480.png"))
		cb()

gulp.task 'test', ->

gulp.task 'build', ['coffee', 'sass', 'vendorJs', 'vendorCss']

gulp.task 'default', ['watch']