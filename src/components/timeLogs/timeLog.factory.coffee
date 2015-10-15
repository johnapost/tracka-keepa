app.factory 'TimeLog', [
  '$http'
  'Utility'
  ($http, Utility) ->
    path = Utility.apiPath()

    getLogs: (data) ->
      $http.get(
        "#{path}/api/timeLogs/logs"
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
