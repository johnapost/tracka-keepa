# Routes
app.config [
  '$stateProvider'
  '$urlRouterProvider'
  ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise '/'

    $stateProvider
      .state 'index',
        url: '/'
        views:
          primaryContent:
            templateUrl: 'posts.html'
        requiresLogin: true
      .state 'register',
        url: '/register'
        views:
          primaryContent:
            templateUrl: 'register.html'
        requiresLogin: false
      .state 'login',
        url: '/login'
        views:
          primaryContent:
            templateUrl: 'login.html'
        requiresLogin: false
]

# Authentication
app.run [
  '$rootScope'
  '$state'
  '$window'
  '$http'
  'User'
  ($rootScope, $state, $window, $http, User) ->

    # Use token as auth header for each request
    if 'token' of $window.localStorage
      $http.defaults.headers.common['X-Auth'] = $window.localStorage.token

    $rootScope.$on '$stateChangeStart', (event, next) ->

      # Check if the route requires login protection
      if next.requiresLogin

        if 'token' of $window.localStorage

          # Check the token
          User.getUser().error (message, code) ->

            # Redirect to safe page if the token is invalid
            if code is 401 or code is 500
              event.preventDefault()
              $state.go 'register'

          # Populate user if token is valid
          .success (data) ->
            User.currentUser = data
            $rootScope.$broadcast 'getUser'

        else

          # Redirect to safe page if no token present
          event.preventDefault()
          $state.go 'register'

]
