app.directive 'unauth', [
  '$firebaseAuth'
  '$animate'
  '$window'
  ($firebaseAuth, $animate, $window) ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      ref = new Firebase appUrl
      auth = $firebaseAuth ref

      # Authenticated user detected, show unauth button
      if auth.$getAuth()
        $(element).css 'display', 'block'

      auth.$onAuth (authData) ->
        if authData
          $(element).velocity 'transition.slideLeftIn', {duration: 600}
        else
          $(element).velocity 'transition.slideRightOut', {duration: 600}

      angular.element(element).bind 'click', ->
        auth.$unauth()
]