describe 'timeLogs directive', ->
  scope = undefined
  element = undefined
  __TimeLog__ = undefined
  __User__ = undefined
  timeout = undefined

  beforeEach ->
    module 'trackaKeepa'
    inject ($compile, $rootScope, TimeLog, User, $timeout) ->
      scope = $rootScope
      __TimeLog__ = TimeLog
      __User__ = User
      timeout = $timeout

      element = $compile(
          angular.element '<div time-logs></div>'
        )(scope)

  it 'should initialize', ->
    spyOn element.scope(), 'initialize'

    timeout.flush()

    expect element.scope().initialize.calls.count()
      .toEqual 1

  describe 'functions:', ->
    it 'initialize get the initial set of logs', ->

    it 'startLog should start running a log', ->
      spyOn __TimeLog__, 'startLog'
      userId = faker.internet.userName()
      isoString = faker.date.recent()
      __User__.currentUser = _id: userId
      window.moment = -> toISOString: -> isoString

      element.scope().startLog()

      expect __TimeLog__.startLog
        .toHaveBeenCalledWith userId: userId, startTime: isoString

    it 'stopLog should stop the running log', ->
      spyOn __TimeLog__, 'stopLog'
      userId = faker.internet.userName()
      isoString = faker.date.recent()
      __User__.currentUser = _id: userId
      window.moment = -> toISOString: -> isoString

      element.scope().stopLog()

      expect __TimeLog__.stopLog
        .toHaveBeenCalledWith userId: userId, stopTime: isoString
