app.directive 'tabContainer', [
  'Utility'
  'Tab'
  '$window'
  (Utility, Tab, $window) ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      tabs = element.children('[tab-toggle]')

      tabToggleWidth = ->
        width = 0
        width += $(n).outerWidth(true) for n in tabs
        width

      tabContainerWidth = ->
        width =
          $(element).outerWidth(true) -
          Utility.DiscountHorizontalOffset($(element)) - 50

      # Responsive tabs
      goResponsive = ->
        $(tabs).hide()
        $(element).css 'border-bottom', '0'
        $(element).css 'padding-left', '0'

        unless $(element).find('.tab-select').length

          # Iterate through tabs and generate an option for each
          htmlString =  "<div class='tab-select'>"
          htmlString +=   "<select id='tab-responsive'>"

          # Match default select option with current tab
          for n in tabs
            if $(n).is '[tab-active]'
              htmlString += "<option val='#{$(n).text()}' selected='selected'>#{$(n).text()}</option>"
            else
              htmlString += "<option val='#{$(n).text()}'>#{$(n).text()}</option>"

          htmlString +=   '</select>'
          htmlString += '</div>'
          $(element).append htmlString

        newSelect = $(element).find 'select'

        # Style the new select element
        newSelect.styleSelect()

        # Dropdown selection changes tab
        angular.element(newSelect).bind 'change', ->
          Tab.toggleTab id: scope.tabSet, tabbed: $(this).val()

      # Normal tabs
      leaveResponsive = ->
        $(tabs).show()
        $(element).css 'border-bottom', ''
        $(element).css 'padding-left', ''
        $(element).find('.tab-select').remove()

      angular.element($window).bind 'load', ->
        if tabToggleWidth() > tabContainerWidth()
          goResponsive()
        else
          leaveResponsive()

      angular.element($window).bind 'resize', ->
        if tabToggleWidth() > tabContainerWidth()
          goResponsive()
        else
          leaveResponsive()
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