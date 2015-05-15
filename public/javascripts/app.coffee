app = angular.module "app", ["ngRoute", "ngAnimate"]

app.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
	$routeProvider
		.when "/",
			templateUrl: "/templates/home"
			controller: "homeController"
		.when "/skills",
			templateUrl: "/templates/skills"
			controller: "skillsController"
		.when "/portfolio",
			templateUrl: "/templates/portfolio"
			controller: "portfolioController"
		.when "/contact",
			templateUrl: "/templates/contact"
			controller: "contactController"

	$locationProvider.html5Mode(true)
]

app.controller "appController", ["$scope", "$timeout", ($scope, $timeout) ->
	$scope.animationActive = false

	$timeout ->
		$scope.animationActive = true
	, 10
]

app.controller "homeController", ["$scope", ($scope) ->
	document.title = "Home | Dominic Liu"
]

app.controller "skillsController", ["$scope", "$timeout", ($scope, $timeout) ->
	document.title = "Skills | Dominic Liu"

	$scope.skills = []
	$scope.search = ""
	$scope.searchFilter = (skill) ->
		skill.name.toLowerCase().indexOf($scope.search.toLowerCase()) >= 0

	skills = [
		{
			name: "AngularJS"
			image: "angular.jpg"
			rating: 3
			extras: ["Protractor"]
			links: [
				{
					name: "This website"
					link: "/"
				}
				{
					name: "Timer"
					link: "http://timer.initiatorapp.com/"
				}
			]
		}
		{
			name: "Ember.js"
			image: "ember.jpg"
			rating: 5
			extras: ["Ember Data"]
			links: [
				{
					name: "Initiator"
					link: "https://initiatorapp.com/"
				}
				{
					name: "DecisiveMe"
					link: "https://decisiveme.com/"
				}
			]
		}
		{
			name: "CoffeeScript"
			image: "coffeescript.jpg"
			rating: 5
			extras: []
			links: [
				{
					name: "Initiator"
					link: "https://initiatorapp.com/"
				}
				{
					name: "DecisiveMe"
					link: "https://decisiveme.com/"
				}
			]
		}
		{
			name: "Node.js"
			image: "node.jpg"
			rating: 5
			extras: ["Express"]
			links: [
				{
					name: "Initiator"
					link: "https://initiatorapp.com/"
				}
				{
					name: "DecisiveMe"
					link: "https://decisiveme.com/"
				}
			]
		}
		{
			name: "PHP"
			image: "php.jpg"
			rating: 5
			extras: ["Twig"]
			links: [
				{
					name: "MapleKit"
					link: "http://mk.youngmaple.ca/"
				}
			]
		}
		{
			name: "MySQL"
			image: "mysql.jpg"
			rating: 5
			extras: []
			links: [
				{
					name: "Initiator"
					link: "https://initiatorapp.com/"
				}
				{
					name: "MapleKit"
					link: "http://mk.youngmaple.ca/"
				}
			]
		}
		{
			name: "MongoDB"
			image: "mongodb.jpg"
			rating: 3
			extras: ["Mongoose"]
			links: [
				{
					name: "DecisiveMe"
					link: "https://decisiveme.com/"
				}
			]
		}
		{
			name: "jQuery"
			image: "jquery.jpg"
			rating: 5
			extras: []
			links: [
				{
					name: "MapleKit"
					link: "http://mk.youngmaple.ca/"
				}
				{
					name: "Initiator"
					link: "https://initiatorapp.com/"
				}
				{
					name: "DecisiveMe"
					link: "https://decisiveme.com/"
				}
			]
		}
		{
			name: "Less"
			image: "less.jpg"
			rating: 5
			extras: []
			links: [
				{
					name: "Initiator"
					link: "https://initiatorapp.com/"
				}
				{
					name: "DecisiveMe"
					link: "https://decisiveme.com/"
				}
			]
		}
		{
			name: "Graphic Design"
			image: "graphic_design.jpg"
			rating: 4
			extras: []
			links: [
				{
					name: "Logo Design"
					link: "https://www.fiverr.com/onlylakehouse/design-a-professional-logo-in-12-hours"
				}
				{
					name: "Cover Design"
					link: "https://www.fiverr.com/onlylakehouse/design-a-kindle-ebook-cover-with-psd-file-included"
				}
			]
		}
		{
			name: "Web Design"
			image: "web_design.jpg"
			rating: 3
			extras: []
			links: [
				{
					name: "This website"
					link: "/"
				}
				{
					name: "Initiator"
					link: "https://initiatorapp.com/"
				}
				{
					name: "MapleKit"
					link: "http://mk.youngmaple.ca/"
				}
			]
		}
		{
			name: "Photography"
			image: "photography.jpg"
			rating: 5
			extras: []
			links: []
		}
		{
			name: "Photoshop"
			image: "photoshop.jpg"
			rating: 5
			extras: []
			links: [
				{
					name: "Cover Design"
					link: "https://www.fiverr.com/onlylakehouse/design-a-kindle-ebook-cover-with-psd-file-included"
				}
			]
		}
		{
			name: "Illustrator"
			image: "Illustrator.jpg"
			rating: 2
			extras: []
			links: [
				{
					name: "Logo Design"
					link: "https://www.fiverr.com/onlylakehouse/design-a-professional-logo-in-12-hours"
				}
			]
		}
		{
			name: "InDesign"
			image: "indesign.jpg"
			rating: 5
			extras: []
			links: []
		}
		{
			name: "Premiere Pro"
			image: "premiere.jpg"
			rating: 5
			extras: []
			links: [
				{
					name: "Maple Style"
					link: "http://v.youku.com/v_show/id_XNDkzMDA0ODY4.html"
				}
			]
		}
		{
			name: "After Effects"
			image: "after_effects.jpg"
			rating: 3
			extras: []
			links: [
				{
					name: "Maple Style"
					link: "http://v.youku.com/v_show/id_XNDkzMDA0ODY4.html"
				}
			]
		}
		{
			name: "Cinematography"
			image: "film.jpg"
			rating: 3
			extras: []
			links: [
				{
					name: "Maple Style"
					link: "http://v.youku.com/v_show/id_XNDkzMDA0ODY4.html"
				}
			]
		}
	]

	$timeout ->
		$scope.skills = skills
	, 10
]

app.controller "portfolioController", ["$scope", ($scope) ->
	document.title = "Portfolio | Dominic Liu"
]

app.controller "contactController", ["$scope", ($scope) ->
	document.title = "Contact | Dominic Liu"
]

app.directive 'ngEnter', ->
	(scope, element, attrs) ->
		element.bind 'keydown keypress', (event) ->
			if event.which == 13
				scope.$apply ->
					scope.$eval attrs.ngEnter, 'event': event
				event.preventDefault()

app.directive 'ngAutoFocus', ->
	(scope, element, attrs) ->
		element[0].focus()
		element[0].selectionStart = element[0].selectionEnd = element[0].value.length # focus at the end

app.directive 'makeFocus', ($timeout) ->
	'use strict'
	(scope, elem, attrs) ->
		scope.$watch attrs.makeFocus, (newVal) ->
			if newVal
				$timeout (->
					elem[0].focus()
				), 0, false

app.directive 'starRating', ->
	{
		restrict: 'EA'
		template: '<ul class=\'rating\' ng-class=\'{readonly: readonly}\'>
						<li ng-repeat=\'star in stars\' ng-class=\'star\' ng-click=\'toggle($index)\'>
							<i class=\'fa fa-star\'></i>
						</li>
					</ul>'
		scope:
			ratingValue: '=ngModel'
			max: '=?'
			onRatingSelected: '&?'
			readonly: '=?'
		link: (scope, elem, attrs) ->

			updateStars = ->
				scope.stars = []
				i = 0
				while i < scope.max
					scope.stars.push filled: i < scope.ratingValue
					i++
				return

			if scope.max == undefined
				scope.max = 5

			scope.toggle = (index) ->
				if scope.readonly == undefined or scope.readonly == false
					scope.ratingValue = index + 1
					scope.onRatingSelected rating: index + 1

			scope.$watch 'ratingValue', (oldVal, newVal) ->
				if newVal
					updateStars()

	}