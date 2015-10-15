app.factory 'TimeLog', [
  '$http'
  'Utility'
  ($http, Utility) ->
    path = Utility.apiPath()

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
