describe 'User factory', ->
  scope = undefined
  __User__ = undefined
  __Socket__ = undefined
  httpBackend = undefined
  window = undefined
  state = undefined
  username = undefined
  password = undefined

  beforeEach ->
    module 'trackaKeepa'
    inject ($httpBackend, User, Socket, $rootScope, $window, $state) ->
      scope = $rootScope
      __User__ = User
      __Socket__ = Socket
      httpBackend = $httpBackend
      window = $window
      state = $state

      username = faker.internet.userName()
      password = faker.internet.password()

      httpBackend.when 'GET', "http://localhost:3000/api/users"
        .respond 200
      httpBackend.when 'POST', "http://localhost:3000/api/users"
        .respond 201

  it 'createUser should create and log in a user', ->
    spyOn __User__, 'login'

    __User__.createUser username, password
    httpBackend.flush()

    expect __User__.login
      .toHaveBeenCalledWith username, password

  it 'getUser should return the current user', ->
    spyOn(__User__, 'getUser').and.callThrough()
    token = faker.internet.password()
    window.localStorage = token

    __User__.getUser()
    httpBackend.flush()

    expect __User__.getUser.calls.mostRecent().returnValue['$$state'].status
      .toEqual 1

  describe 'login', ->
    it 'should log in a user on success', ->
      httpBackend.when 'POST', "http://localhost:3000/api/sessions"
        .respond 201
      spyOn(__User__, 'getUser').and.callThrough()
      spyOn state, 'go'

      __User__.login username, password
      httpBackend.flush()

      expect state.go
        .toHaveBeenCalledWith 'index'

    it 'should log out on error', ->
      httpBackend.when 'POST', "http://localhost:3000/api/sessions"
        .respond 404
      spyOn __User__, 'logout'

      __User__.login username, password
      httpBackend.flush()

      expect __User__.logout.calls.count()
        .toEqual 1

  it 'logout should log out a user', ->
    spyOn __Socket__, 'disconnect'
    spyOn scope, '$broadcast'

    __User__.logout()

    expect __User__.currentUser
      .toEqual undefined
    expect __Socket__.disconnect.calls.count()
      .toEqual 1
    expect scope.$broadcast
      .toHaveBeenCalledWith 'logout'
