app = angular.module "app", ["ngRoute"]

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

app.controller "homeController", ["$scope", ($scope) ->
	document.title = "Home | Dominic Liu"
]

app.controller "skillsController", ["$scope", ($scope) ->
	document.title = "Skills | Dominic Liu"
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