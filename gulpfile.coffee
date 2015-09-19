app = require("./app")
coffee = require('gulp-coffee')
gulp = require 'gulp'
gutil = require('gulp-util')
sourcemaps = require('gulp-sourcemaps')

dirs =
	js: "./public/javascripts/"

globs = 
	coffee: "#{dirs.js}*.coffee"

gulp.task 'serve', ->
	app.set "port", process.env.PORT or 3000
	server = app.listen(app.get("port"), ->
		console.log "Express server listening on port " + server.address().port
		return
	)

gulp.task 'coffee', ->
	gulp.src(globs.coffee)
		.pipe(sourcemaps.init())
		.pipe(coffee(bare: true).on('error', gutil.log))
		.pipe(sourcemaps.write())
		.pipe gulp.dest(dirs.js)

gulp.task 'watch', ['coffee'], ->
	gulp.watch globs.coffee, ['coffee']

gulp.task 'default', ['coffee', 'serve'], ->