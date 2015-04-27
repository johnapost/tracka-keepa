app.directive 'loginForm', [
  '$firebaseAuth'
  '$timeout'
  ($firebaseAuth, $timeout) ->
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

          # Reset form to pristine after submission
          $timeout ->
            scope.$apply ->
              scope.user =
                email: null
                password: null
              notification.text ''
          , 600
        .catch (error) ->
          notification.text error
]