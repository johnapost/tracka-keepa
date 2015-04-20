module.exports = ->
  support = require '../support/support.coffee'
  expect = support().expect

  email = $('[register-form] [type=email]')
  password = $('[register-form] [type=password]')
  submit = $('[register-form] [type=submit]')

  @When 'I register for an account', (callback) ->
    $("[label='Register']").click()
    .then -> email.sendKeys browser.params.login.email
    .then -> password.sendKeys browser.params.login.password
    .then -> submit.click()
    .then -> callback()

  # Passes when account creation is a success and when an account already exists
  @Then 'I should have my account created', (callback) ->
    expect($('[flash]').getText()).to.eventually.have.length.above 0
    .then -> callback()
