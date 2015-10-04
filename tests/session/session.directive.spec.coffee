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
      username = faker.hacker.noun()
      password = faker.hacker.noun()

      element.scope().login username, password

      expect __User__.login
        .toHaveBeenCalledWith username, password
