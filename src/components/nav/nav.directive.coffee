app.directive 'nav', [
  'User'
  (User) ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      scope.currentUser =
        username: null

      scope.$on 'getUser', (ev, val) ->
        scope.currentUser.username = User.currentUser.username

      scope.$on 'logout', ->
        scope.currentUser =
          username: undefined
]
