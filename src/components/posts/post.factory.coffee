app.factory 'Post', [
  '$http'
  '$window'
  'Utility'
  ($http, $window, Utility) ->
    path = Utility.apiPath()

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
