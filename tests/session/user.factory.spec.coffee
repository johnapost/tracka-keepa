describe 'User factory', ->
  scope = undefined
  __User__ = undefined
  httpBackend = undefined

  beforeEach ->
    module 'trackaKeepa'
    inject ($httpBackend, User, $rootScope) ->
      scope = $rootScope
      __User__ = User
      httpBackend = $httpBackend

  it 'createUser should create and log in a user', ->

  it 'getUser should return the current user', ->

  it 'login should log in a user', ->

  it 'logout should log out a user', ->
