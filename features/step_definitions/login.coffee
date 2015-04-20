module.exports = ->
  support = require '../support/support.coffee'
  expect = support().expect

  email = $('[login-form] [type=email]')
  password = $('[login-form] [type=password]')
  submit = $('[login-form] [type=submit]')
  notification = $('[login-form] [notification]')

  @When 'I visit the homepage', (callback) ->
    browser.get '/?mock=true'
    .then -> expect(browser.getTitle()).to.eventually.equal 'Tracka Keepa'
    .then -> callback()

  @When 'I login to my account with valid credentials', (callback) ->
    email.sendKeys browser.params.login.email
    .then -> password.sendKeys browser.params.login.password
    .then -> submit.click()
    .then -> callback()

  @When 'I login to my account with invalid credentials', (callback) ->
    email.sendKeys browser.params.login.email
    .then -> password.sendKeys 'badpassword'
    .then -> submit.click()
    .then -> callback()

  @Then 'I should see my dashboard', (callback) ->
    expect(notification.getText()).to.eventually.equal 'Welcome back!'
    .then -> callback()

  @Then 'I should see an error message', (callback) ->
    expect(notification.getText()).to.eventually.include 'Error'
    .then -> callback()
