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

      unless auth.$getAuth()
        $(element).css 'display', 'block'

        auth.$onAuth (authData) ->
          $(element).velocity 'transition.slideUpOut', {duration: 600} if authData

]