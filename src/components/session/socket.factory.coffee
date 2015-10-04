app.factory 'Socket', [
  'socketFactory'
  '$window'
  (socketFactory, $window) ->
    path = "http://localhost:3000"

    socketFactory
      prefix: ''
      ioSocket: io.connect path
]
