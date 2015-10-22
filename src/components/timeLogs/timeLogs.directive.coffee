app.directive 'timeLogs', [
  'TimeLog'
  'User'
  '$timeout'
  (TimeLog, User, $timeout) ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      scope.logs = Array()

      # Initial retrieval of logs
      scope.initialize = ->
        TimeLog.getLogs().success (data) -> scope.logs = data

      # Start running a log
      scope.startLog = ->
        input = startTime: moment().toISOString()

        TimeLog.startLog input

      # Stop the running log
      scope.stopLog = ->
        input = stopTime: moment().toISOString()

        TimeLog.stopLog input

      $timeout ->
        scope.initialize()
      , 0
]
