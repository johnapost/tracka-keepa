app.factory 'Post', [
  '$http'
  '$window'
  ($http, $window) ->
    path = $window.location.origin.replace ':4000', ':3000'

    getPosts: ->
      $http.get(
        "#{path}/api/posts"
        cache: true
        transformResponse: (data) ->
          JSON.parse data
      )

    addPost: (data) ->
      $http.post(
        "#{path}/api/posts"
        data
      )
]
