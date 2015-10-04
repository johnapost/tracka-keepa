app.factory 'Socket', [
  'socketFactory'
  '$window'
  'Utility'
  (socketFactory, $window, Utility) ->
    path = Utility.apiPath()

    socketFactory
      prefix: ''
      ioSocket: io.connect path
]
