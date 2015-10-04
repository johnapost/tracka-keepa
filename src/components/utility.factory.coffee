app.factory 'Utility', [
  '$window'
  ($window) ->
    apiPath: ->
      "#{$window.location.protocol}//#{$window.location.hostname}:3000"
]
