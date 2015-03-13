app.controller 'tabToggleController', [
  '$scope'
  'Tab'
  ($scope, Tab) ->

    # Announce to Tab factory that I need a new tabSet assigned
    $scope.tabSet = Tab.newTabSet()
]