express = require "express"
router = express.Router()
skills = require "./skills"
works = require "./works"
_ = require "underscore"

for skill in skills
	skill.hasWorks = false

for work in works
	work.skillsWithImages = []
	for skill in work.skills
		matchedSkill = _.findWhere skills,
			name: skill
		if matchedSkill
			matchedSkill.hasWorks = true
			work.skillsWithImages.push
				name: skill
				image: matchedSkill.image

router.get "/skills", (req, res) ->
	res.send
		skills: skills

router.get "/works", (req, res) ->
	res.send
		works: works

module.exports = router