module.exports = ->
  support = require '../support/support.coffee'
  expect = support().expect

  authCard = $('[auth-card]')
  unauth = $('[unauth]')

  @When 'I logout from my account', (callback) ->
    unauth.click()
    .then -> callback()

  @Then 'I should see the login card', (callback) ->
    expect(authCard.isDisplayed()).to.eventually.equal true
    .then -> callback()