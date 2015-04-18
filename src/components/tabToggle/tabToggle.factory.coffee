app.factory 'Tab', [
  '$rootScope'
  ($rootScope) ->
    tabSets = []

    # Create new tabSet
    newTabSet: ->
      tabSet = tabSets.length + 1
      tabSets.push id: tabSet, tabbed: ''

      tabSet

    # Accept toggle actions and broadcast event
    toggleTab: (args) ->

      # Loop through tabSets to find the correct one
      for n in tabSets
        if n.id is args.id
          n.tabbed = args.tabbed

          # Broadcast relevant toggle event
          $rootScope.$broadcast 'tabToggle', n
          break
]