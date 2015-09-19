gulp = require 'gulp'
app = require("./app")

gulp.task 'serve', ->
	app.set "port", process.env.PORT or 3000
	server = app.listen(app.get("port"), ->
		console.log "Express server listening on port " + server.address().port
		return
	)

gulp.task 'default', ['serve'], ->