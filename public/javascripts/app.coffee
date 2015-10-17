app = angular.module "app", ['ngAnimate', "ui.router", 'ui.bootstrap', "wu.masonry", 'headroom']

app.config ["$stateProvider", '$urlRouterProvider', '$locationProvider',
	($stateProvider, $urlRouterProvider, $locationProvider) ->
		$locationProvider.html5Mode true
		$urlRouterProvider.otherwise('/')
		$stateProvider
			.state 'home',
				url: "/",
				templateUrl: "/templates/home"
				controller: "homeController"
			.state 'skills',
				url: "/skills?search",
				templateUrl: "/templates/skills"
				controller: "skillsController"
			.state 'portfolio',
				url: "/portfolio?search",
				templateUrl: "/templates/portfolio"
				controller: "portfolioController"
			.state 'contact',
				url: "/contact",
				templateUrl: "/templates/contact"
				controller: "contactController"
]

app.factory "utils", ->
	return {
		setTitle: (title) ->
			document.title = "#{title} | Dominic Liu"
	}

app.controller "appController", ["$scope", "$timeout", "$location",
	($scope, $timeout, $location) ->
		$scope.animationActive = false

		$scope.isActive = (path) ->
			$location.path() is path
		$scope.toggleNavbar = ->
			$("button.navbar-toggle:visible").click()
			return

		$timeout ->
			$scope.animationActive = true
		, 10
]

app.controller "homeController", ["$scope", "utils", ($scope, utils) ->
	utils.setTitle("Home")
]

app.controller "skillsController",
	["$scope", "$timeout", "$stateParams", "$http", "utils",
		($scope, $timeout, $stateParams, $http, utils) ->
			utils.setTitle("Skills")

			$scope.skills = []
			$scope.search = $stateParams.search or ""
			$scope.searchFilter = (skill) ->
				skill.name.toLowerCase().indexOf($scope.search.toLowerCase()) >= 0

			$http.get "/api/skills"
				.then (response) ->
					$scope.skills = response.data.skills
	]

app.controller "portfolioController",
	["$scope", "$timeout", "$stateParams", "$http", "utils",
		($scope, $timeout, $stateParams, $http, utils) ->
			utils.setTitle("Portfolio")

			$scope.works = []
			$scope.search = $stateParams.search or ""
			$scope.searchFilter = (work) ->
				matchedSkills = []
				angular.forEach work.skills, (skill) ->
					@push skill if skill.toLowerCase().indexOf($scope.search.toLowerCase()) >= 0
				, matchedSkills
				matchedSkills.length or work.name.toLowerCase().indexOf($scope.search.toLowerCase()) >= 0
			$scope.currentWork = null

			$scope.images = []

			$http.get "/api/works"
				.then (response) ->
					$scope.works = response.data.works
					angular.forEach $scope.works, (work) ->
						@push "/images/portfolio/" + work.image
					, $scope.images
	]

app.controller "contactController", ["$scope", "utils", ($scope, utils) ->
	utils.setTitle("Contact")
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
		element[0].selectionStart = element[0].selectionEnd =
			element[0].value.length # focus at the end

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

app.directive 'vivus', ->
	{
		link: (scope, elem, attrs) ->
			unless attrs.id
				throw new Error "No id on the Vivus element detected."
			new Vivus attrs.id,
				type: 'delayed'
				duration: 150
				delay: -2000
				file: '/images/dominic.svg'
			return
	}