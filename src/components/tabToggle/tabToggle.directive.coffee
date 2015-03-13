app.directive 'tabSet', [
  'Tab'
  (Tab) ->
    restrict: 'A'
    scope: true
    link: (scope, element, attrs) ->

      # Announce to Tab factory that I need a new tabSet assigned
      scope.tabSet = Tab.newTabSet()
]

# Controls toggle state
app.directive 'tabToggle', [
  'Tab'
  (Tab) ->
    restrict: 'A'
    link: (scope, element, attrs) ->

      # Identify self as toggling to factory
      angular.element(element).bind 'click', ->

        unless $(element).is '[tab-active]'

          # Pass my tabSet and tabToggle to factory
          Tab.toggleTab id: scope.tabSet, tabbed: attrs.tabToggle

      # Listen for tabToggle event
      scope.$on 'tabToggle', (ev, val) ->
        if scope.tabSet is val.id

          # Add active attribute for any CSS needs
          if attrs.tabToggle is val.tabbed
            $(element).attr 'tab-active', ''
          else
            $(element).removeAttr 'tab-active'
]

# Listens for state and animates
app.directive 'tabContent', [
  ->
    restrict: 'A'
    link: (scope, element, attrs) ->

      openTab = -> $(element).attr 'tab-active', ''
      closeTab = -> $(element).removeAttr 'tab-active'

      # Listen for matching toggle event
      scope.$on 'tabToggle', (ev, val) ->
        if scope.tabSet is val.id
          if attrs.tabContent is val.tabbed
            openTab()
          else
            closeTab()
]