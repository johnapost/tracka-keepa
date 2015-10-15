app.factory 'Post', [
  '$http'
  'Utility'
  ($http, Utility) ->
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
