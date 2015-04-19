module.exports = ->

  # Monkey Patch for Error Reporting: https://github.com/cucumber/cucumber-js/issues/157
  path = require('path')
  filteredPathPrefix = path.resolve(__dirname, '..')
  originalPrepareStackTrace = undefined
  stackTraceDepth = 1
  if originalPrepareStackTrace = Error.prepareStackTrace

    Error.prepareStackTrace = (error, stack) ->
      message = [ error.name + ': ' + error.message ]
      i = 0
      while i < stack.length
        if stack[i].getFileName().indexOf(filteredPathPrefix) == 0
          message.push '  at ' + stack[i]
        i++
      message.slice(0, stackTraceDepth + 1).join '\n'

  # Testing support
  chai = require 'chai'
  chaiAsPromised = require 'chai-as-promised'
  chai.use chaiAsPromised
  expect = chai.expect
  request = require 'request'

  # E2E proof-of-concept
  # firebaseTokenGenerator = require 'firebase-token-generator'
  # tokenGenerator = new firebaseTokenGenerator process.env.FIREBASE_TRACKA_KEEPA_SECRET
  # token = tokenGenerator.createToken {uid: 'admin'}, {admin: true}

  expect: expect, request: request