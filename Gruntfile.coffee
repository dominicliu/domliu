module.exports = (grunt) ->
	grunt.initConfig
		watch:
			coffee:
				files: 'public/javascripts/*.coffee'
				tasks: ['coffee:compile']
				options:
					atBegin: true
			less:
				files: ["<%= dirs.less %>/**/*.less"]
				tasks: ["less:compile"]
				options:
					atBegin: true
			uglify:
				files: ["public/javascripts/app.js"]
				tasks: ["uglify:js"]
				options:
					atBegin: true
		coffee:
			compile:
				expand: true,
				flatten: true,
				cwd: "#{__dirname}/public/javascripts",
				src: ['*.coffee'],
				dest: 'public/javascripts',
				ext: '.js'
				options:
					bare: true
		uglify:
			js:
				files:
					"public/javascripts/app.min.js": "public/javascripts/app.js"
				options:
					sourceMap: true
		dirs:
			less: "public/stylesheets/less"
		
		less:
			compile:
				files:
					"public/stylesheets/css/style.min.css": "<%= dirs.less %>/style.less"
				options:
					cleancss: true
					compress: true

	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-contrib-watch"
	grunt.loadNpmTasks "grunt-contrib-less"
	grunt.loadNpmTasks('grunt-contrib-uglify')
	grunt.registerTask "build", ["coffee:compile", "less:compile", "uglify:js"]