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
    element By.css('.email').sendkeys('testemail@testemail.com')
    element By.css('.password').sendkeys('testpassword')
    element By.css('.submit').click()
    callback()

  @When 'I login to my account with invalid credentials', (callback) ->
    element By.css('.email').sendkeys('testemail@testemail.com')
    element By.css('.password').sendkeys('badpassword')
    element By.css('.submit').click()
    callback.pending()

  @Then 'I should see my dashboard', (callback) ->
    if element By.css('.dashboard')
      callback()
    else
      callback.fail()

  @Then 'I should see an error message', (callback) ->
    if element By.css('.error')
      callback()
    else
      callback.fail()