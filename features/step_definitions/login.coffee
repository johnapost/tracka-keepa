module.exports = ->
  # Refactor this out to a support file
  chai = require 'chai'
  chaiAsPromised = require 'chai-as-promised'
  chai.use chaiAsPromised
  expect = chai.expect
  require('hide-stack-frames-from') 'cucumber'

  # Elements
  email = element By.css('#email')
  password = element By.css('#password')
  submit = element By.css('#submit')

  @When 'I visit the homepage', (callback) ->
    browser.get '/'
    callback()

  @When 'I login to my account with valid credentials', (callback) ->
    email.sendKeys 'testemail@testemail.com'
    password.sendKeys 'testpassword'
    submit.click()

    if email.getText() is 'testemail@testemail.com'
      callback()
    else
      callback.fail()

  @When 'I login to my account with invalid credentials', (callback) ->
    element(By.css('#email')).sendKeys 'testemail@testemail.com'
    password.sendKeys 'badpassword'
    submit.click()
    callback()

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