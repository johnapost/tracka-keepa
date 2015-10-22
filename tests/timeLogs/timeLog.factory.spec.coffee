describe 'TimeLog factory', ->
  __TimeLog__ = undefined
  httpBackend = undefined

  beforeEach ->
    module 'trackaKeepa'
    inject ($httpBackend, TimeLog, $rootScope) ->
      scope = $rootScope
      __TimeLog__ = TimeLog
      httpBackend = $httpBackend

  describe 'functions', ->
    it 'getLogs should get all logs that belong to a user', ->
      spyOn(__TimeLog__, 'getLogs').and.callThrough()
      httpBackend.when 'GET', "http://localhost:3000/api/timeLogs"
        .respond [
          {startTime: moment(), stopTime: moment()},
          {startTime: moment(), stopTime: moment()}
        ]

      __TimeLog__.getLogs()
      httpBackend.flush()

      expect(
        __TimeLog__.getLogs.calls.mostRecent().returnValue['$$state'].status
      ).toEqual 1

    it 'startLog should post to service to start running a log', ->
      spyOn(__TimeLog__, 'startLog').and.callThrough()
      httpBackend.when 'POST', "http://localhost:3000/api/timeLogs/start"
        .respond 201

      __TimeLog__.startLog()
      httpBackend.flush()

      expect(
        __TimeLog__.startLog.calls.mostRecent().returnValue['$$state'].status
      ).toEqual 1

    it 'stopLog should post to service to stop running the log', ->
      spyOn(__TimeLog__, 'stopLog').and.callThrough()
      httpBackend.when 'POST', "http://localhost:3000/api/timeLogs/stop"
        .respond 201

      __TimeLog__.stopLog()
      httpBackend.flush()

      expect(
        __TimeLog__.stopLog.calls.mostRecent().returnValue['$$state'].status
      ).toEqual 1

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()
