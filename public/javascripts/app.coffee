app = angular.module "app", []

app.controller "indexController", ["$scope", ($scope) ->
	
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