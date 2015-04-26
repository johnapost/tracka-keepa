app.directive 'authCard', [
  '$firebaseAuth'
  '$animate'
  '$window'
  ($firebaseAuth, $animate, $window) ->
    restrict: 'A'
    scope: true
    link: (scope, element, attrs) ->
      ref = new Firebase appUrl
      auth = $firebaseAuth ref

      # Log out the user for tests
      if $window.location.search.indexOf('unauth=true') > -1
        auth.$unauth()

      # Unauthenticated user detected, show authCard
      unless auth.$getAuth()
        $(element).css 'display', 'block'

      auth.$onAuth (authData) ->
        if authData
          $(element).velocity 'transition.slideRightOut', {duration: 600}
        else
          $(element).velocity 'transition.slideLeftIn', {duration: 600}

]