express = require "express"
router = express.Router()

router.get "/home", (req, res) ->
	res.render "home"

router.get "/skills", (req, res) ->
	res.render "skills"

router.get "/portfolio", (req, res) ->
	res.render "portfolio"

router.get "/contact", (req, res) ->
	res.render "contact"

module.exports = router