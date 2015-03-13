module.exports = ->
  support = require '../support/support.coffee'
  expect = support().expect

  email = $('[register-form] .email')
  password = $('[register-form] .password')
  submit = $('[register-form] .submit')

  @When 'I register for an account', (callback) ->
    $("[tab-toggle='Register']").click()
    .then -> email.sendKeys browser.params.login.email
    .then -> password.sendKeys browser.params.login.password
    .then -> submit.click()
    .then -> callback()

  @Then 'I should have my account created', (callback) ->
    expect $('.flash').getText().to.eventually.equal 'Account successfully created'
    .then -> callback()