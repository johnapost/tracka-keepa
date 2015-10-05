app.factory 'TimeLog', [
  '$http'
  'Utility'
  ($http, Utility) ->
    path = Utility.apiPath()

    # startLog: (data) ->
    #   $http.post(
    #     "#{path}/api/timeLogs"
    #     data
    #   )

    # stopLog: (data) ->
    #   $http.post(
    #     "#{path}/api/timeLogs"
    #     data
    #   )
]
