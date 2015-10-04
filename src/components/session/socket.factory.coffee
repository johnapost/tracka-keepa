app.factory 'Socket', [
  'socketFactory'
  '$window'
  (socketFactory, $window) ->
    path = $window.location.origin.replace ':4000', ':3000'

    socketFactory
      prefix: ''
      ioSocket: io.connect path
]
