app.directive 'registerForm', [
  '$firebase'
  ($firebase) ->
    restrict: 'A'
    scope: true
    link: (scope, element, attrs) ->
      ref = new Firebase appUrl

      scope.user =
        email: null
        password: null

      scope.submit = ->
        ref.createUser
          email: scope.user.email
          password: scope.user.password
        , (error, userData) ->
          if (error)
            console.log "Error creating user: #{error}"
          else
            console.log "Successfully created user account"
            $('[flash]').text 'Account successfully created'
]