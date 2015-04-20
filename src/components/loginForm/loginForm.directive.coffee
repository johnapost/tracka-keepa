app.directive 'loginForm', [
  '$firebaseAuth'
  ($firebaseAuth) ->
    restrict: 'A'
    scope: true
    link: (scope, element, attrs) ->
      ref = new Firebase appUrl
      auth = $firebaseAuth ref
      notification = $(element).find '[notification]'

      scope.user =
        email: null
        password: null

      scope.submit = ->
        auth.$authWithPassword
          email: scope.user.email
          password: scope.user.password
        .then (authData) ->
          notification.text 'Welcome back!'
        .catch (error) ->
          notification.text error
]