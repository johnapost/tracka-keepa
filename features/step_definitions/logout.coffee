module.exports = ->
  support = require '../support/support.coffee'
  expect = support().expect

  email = $('[login-form] [type=email]')
  password = $('[login-form] [type=password]')
  notification = $('[login-form] [notification]')
  authCard = $('[auth-card]')
  unauth = $('[unauth]')

  @When 'I logout from my account', (callback) ->
    unauth.click()
    .then -> callback()

  @Then 'I should see the login card', (callback) ->
    expect(authCard.isDisplayed()).to.eventually.equal true
    .then -> callback()

  @Then 'the login form should be cleared', (callback) ->
    expect(email.getAttribute 'value').to.eventually.equal ''
    .then -> expect(password.getAttribute 'value').to.eventually.equal ''
    .then -> expect(notification.getText()).to.eventually.equal ''
    .then -> callback()