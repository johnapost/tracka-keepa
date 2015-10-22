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

  it 'should have an empty list of logs', ->
    expect element.scope().logs
      .toEqual []

  it 'should initialize', ->
    spyOn element.scope(), 'initialize'

    timeout.flush()

    expect element.scope().initialize.calls.count()
      .toEqual 1

  describe 'functions:', ->
    it 'initialize get the initial set of logs', ->
      data = faker.lorem.words(1)[0]
      spyOn(__TimeLog__, 'getLogs').and.callFake ->
        success: (cb) -> cb({data})

      element.scope().initialize()

      expect element.scope().logs
        .toEqual data: data

    it 'startLog should start running a log', ->
      spyOn __TimeLog__, 'startLog'
      isoString = faker.date.recent()
      window.moment = -> toISOString: -> isoString

      element.scope().startLog()

      expect __TimeLog__.startLog
        .toHaveBeenCalledWith startTime: isoString

    it 'stopLog should stop the running log', ->
      spyOn __TimeLog__, 'stopLog'
      isoString = faker.date.recent()
      window.moment = -> toISOString: -> isoString

      element.scope().stopLog()

      expect __TimeLog__.stopLog
        .toHaveBeenCalledWith stopTime: isoString
