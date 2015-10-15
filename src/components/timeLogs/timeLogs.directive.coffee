app.directive 'timeLogs', [
  'TimeLog'
  'User'
  '$timeout'
  (TimeLog, User, $timeout) ->
    restrict: 'A'
    link: (scope, element, attrs) ->

      # Initial retrieval of logs
      scope.initialize = ->

      # Start running a log
      scope.startLog = ->
        input =
          userId: User.currentUser._id
          startTime: moment().toISOString()

        TimeLog.startLog input

      # Stop the running log
      scope.stopLog = ->
        input =
          userId: User.currentUser._id
          stopTime: moment().toISOString()

        TimeLog.stopLog input

      $timeout ->
        scope.initialize()
      , 0
]
