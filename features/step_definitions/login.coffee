module.exports = ->
  # Refactor this out to a support file
  chai = require 'chai'
  chaiAsPromised = require 'chai-as-promised'
  chai.use chaiAsPromised
  expect = chai.expect
  require('hide-stack-frames-from') 'cucumber'

  @When 'I visit the homepage', (callback) ->
    browser.get '/'
    callback()

  @When 'I login to my account with valid credentials', (callback) ->
    callback.pending()

  @When 'I login to my account with invalid credentials', (callback) ->
    callback.pending()

  @Then 'I should see my dashboard', (callback) ->
    callback.pending()

  @Then 'I should see an error message', (callback) ->
    callback.pending()