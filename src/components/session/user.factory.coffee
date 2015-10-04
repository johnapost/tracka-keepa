app.factory 'User', [
  '$http'
  '$rootScope'
  '$window'
  '$state'
  'Socket'
  'Utility'
  ($http, $rootScope, $window, $state, Socket, Utility) ->
    path = Utility.apiPath()

    currentUser: ''

    createUser: (username, password) ->
      $http.post(
        "#{path}/api/users"
        {
          username: username
          password: password
        }
      ).success =>
        @login username, password

    getUser: ->
      $http.get(
        "#{path}/api/users"
        headers:
          'X-Auth': $window.localStorage.token
      )

    login: (username, password) ->
      $http.post(
        "#{path}/api/sessions"
        {
          username: username
          password: password
        }
      ).success (val) =>
        $window.localStorage.token = val
        $http.defaults.headers.common['X-Auth'] = val
        @getUser().success ->
          $state.go 'index'
      .error => @logout()

    logout: ->
      $window.localStorage.removeItem 'token'
      @currentUser = undefined
      $http.defaults.headers.common['X-Auth'] = undefined
      Socket.disconnect()
      $rootScope.$broadcast 'logout'
]
