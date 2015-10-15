app.factory 'TimeLog', [
  '$http'
  'Utility'
  ($http, Utility) ->
    path = Utility.apiPath()

    getLogs: ->
      $http.get(
        "#{path}/api/timeLogs"
        cache: true
        transformResponse: (data) ->
          data = JSON.parse data unless angular.isObject data

          for log in data
            log.startTime = moment(log.startTime).format 'h:mm:ss a - MMM D, YYYY'

            if log.stopTime
              log.stopTime = moment(log.stopTime).format 'h:mm:ss a - MMM D, YYYY'

          data
      )

    # Post to service to start running a log
    startLog: (data) ->
      $http.post(
        "#{path}/api/timeLogs/start"
        data
      )

    # Post to service to stop the running log
    stopLog: (data) ->
      $http.post(
        "#{path}/api/timeLogs/stop"
        data
      )
]
