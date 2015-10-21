describe 'Session directive', ->
  rootScope = undefined
  scope = undefined
  element = undefined
  __User__ = undefined

  beforeEach ->
    module 'trackaKeepa'
    inject ($compile, $rootScope, User) ->
      rootScope = $rootScope
      scope = rootScope.$new()
      __User__ = User

      element = $compile(
          angular.element '<div session></div>'
        )(scope)

  describe 'functions:', ->
    it 'login should call User login', ->
      spyOn __User__, 'login'
      username = faker.internet.userName()
      password = faker.internet.password()

      element.scope().login username, password

      expect __User__.login
        .toHaveBeenCalledWith username, password

    it 'logout should call logout', ->
      spyOn __User__, 'logout'

      element.scope().logout()

      expect __User__.logout.calls.count()
        .toEqual 1

    it 'register should create a user', ->
      spyOn __User__, 'createUser'
      username = faker.internet.userName()
      password = faker.internet.password()

      element.scope().register username, password

      expect __User__.createUser
        .toHaveBeenCalledWith username, password
