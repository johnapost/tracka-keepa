module.exports = ->
  support = require '../support/support.coffee'
  expect = support().expect

  email = element By.css('#email')
  password = element By.css('#password')
  submit = element By.css('#submit')

  @When 'I register for an account', (callback) ->
    callback.pending()

  @Then 'I should have my account created', (callback) ->
    callback.pending()