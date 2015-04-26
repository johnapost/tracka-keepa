app.directive 'unauth', [
  '$firebaseAuth'
  '$animate'
  '$window'
  ($firebaseAuth, $animate, $window) ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      ref = new Firebase appUrl
      auth = $firebaseAuth ref

      # Authenticated user detected, show unauthCard
      if auth.$getAuth()
        $(element).css 'display', 'block'

      auth.$onAuth (authData) ->
        $(element).velocity 'transition.slideLeftIn', {duration: 600} if authData

]