app.directive 'loginForm', [
  ->
    restrict: 'A'
    scope: true
    link: (scope, element, attrs) ->
      scope.user =
        email: null
        password: null

      scope.submit = ->
        console.log scope.user
]