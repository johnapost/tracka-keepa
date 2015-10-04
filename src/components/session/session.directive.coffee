app.directive 'session', [
  'User'
  '$window'
  (User, $window) ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      scope.login = (username, password) -> User.login username, password

      scope.logout = -> User.logout()

      scope.register = (username, password) ->
        User.createUser username, password
]
