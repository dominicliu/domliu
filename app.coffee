express = require("express")
path = require("path")
favicon = require("static-favicon")
logger = require("morgan")
cookieParser = require("cookie-parser")
bodyParser = require("body-parser")
compression = require("compression")
routes = require("./routes/index")
templates = require("./routes/templates")
api = require("./routes/api")
app = express()

# view engine setup
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"
app.use compression()
app.use favicon()
app.use logger("dev")
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use cookieParser()
app.use express.static(path.join(__dirname, "public"))

app.use "/templates", templates
app.use "/api", api

app.use "/", routes
app.use "/skills", routes
app.use "/portfolio", routes
app.use "/contact", routes

#/ catch 404 and forward to error handler
app.use (req, res, next) ->
	err = new Error("Not Found")
	err.status = 404
	next err
	return


#/ error handlers

# development error handler
# will print stacktrace
if app.get("env") is "development"
	app.use (err, req, res, next) ->
		res.status err.status or 500
		res.render "error",
			message: err.message
			error: err

		return


# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
	res.status err.status or 500
	res.render "error",
		message: err.message
		error: {}

	return

app.set "port", process.env.PORT or 3000
server = app.listen(app.get("port"), ->
	console.log "Express server listening on port " + server.address().port
	return
)

module.exports = app