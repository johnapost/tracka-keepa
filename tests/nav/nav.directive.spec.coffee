describe 'Nav directive', ->
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
        angular.element "<div nav></div>"
      )(scope)

  it 'should have a null current user', ->
    expect element.scope().currentUser
      .toEqual username: null

  describe 'event listeners:', ->
    it 'getUser should update the username', ->
      name = faker.hacker.noun()
      __User__.currentUser = username: name

      rootScope.$broadcast 'getUser'

      expect element.scope().currentUser.username
        .toEqual name

    it 'logout should remove the current user', ->
      rootScope.$broadcast 'logout'

      expect element.scope().currentUser.username
        .toEqual undefined
