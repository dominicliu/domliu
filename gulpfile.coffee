app = require("./app")
gulp = require 'gulp'

autoprefixer = require 'autoprefixer'
browserSync = undefined
coffee = require('gulp-coffee')
gutil = require('gulp-util')
minifyCSS = require('gulp-minify-css')
postcss = require 'gulp-postcss'
rename = require('gulp-rename')
sass = require 'gulp-sass'
sourcemaps = require('gulp-sourcemaps')
uglify = require('gulp-uglify')

dirs =
	js: "./public/javascripts/"
	sass: "./public/stylesheets/sass/"
	css: "./public/stylesheets/css/"
	jade: "./views/"

globs = 
	coffee: "#{dirs.js}*.coffee"
	sass: "#{dirs.sass}style.scss"
	jade: "#{dirs.jade}*.jade"

port = process.env.PORT or 3000

gulp.task 'serve', ->
	app.set "port", port
	server = app.listen(app.get("port"), ->
		console.log "Express server listening on port " + server.address().port
		return
	)

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
		.pipe sass()
		.pipe postcss([autoprefixer({ browsers: ['> 5%'] }) ])
		.pipe minifyCSS()
		.pipe rename({suffix:'.min'})
		.pipe(sourcemaps.write())
		.pipe gulp.dest(dirs.css)

gulp.task 'sass', ->
	compileSass()

gulp.task 'browser-sync-sass', ->
	compileSass().pipe browserSync.stream()

gulp.task 'browser-sync', ['serve'], ->
	browserSync = require('browser-sync').create()
	browserSync.init
		proxy: "localhost:#{port}"
		ui:
			port: 8080

gulp.task 'watch', ['serve', 'browser-sync', 'coffee', 'sass'], ->
	gulp.watch globs.coffee, ['coffee']
		.on 'change', browserSync.reload
	gulp.watch globs.sass, ['browser-sync-sass']
	gulp.watch globs.jade, browserSync.reload

gulp.task 'build', ['coffee', 'sass']

gulp.task 'default', ['watch', 'serve']