app.directive 'timeLogs', [
  'TimeLog'
  'User'
  'Moment'
  (TimeLog, User, Moment) ->
    restrict: 'A'
    link: (scope, element, attrs) ->

      # Initial retrieval of logs

      # Post a log
      scope.addLog = ->
        input =
          userId: User.currentUser._id
          startTime: Moment.toISOString()

        console.log input

        # TimeLog.addLog
]
