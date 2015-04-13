app.directive 'registerForm', [
  '$firebaseAuth'
  ($firebaseAuth) ->
    restrict: 'A'
    scope: true
    link: (scope, element, attrs) ->
      ref = new Firebase appUrl
      auth = $firebaseAuth ref

      scope.user =
        email: null
        password: null

      scope.submit = ->
        auth.$createUser
          email: scope.user.email
          password: scope.user.password
        .then (userData) ->
          console.log "Successfully created user account: #{userData.uid}"
          $('[flash]').text 'Account successfully created'
        .catch (error) ->
          console.log "Error creating user: #{error}"
]