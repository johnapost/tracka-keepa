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

  @Then 'I should have my account created', (callback) ->
    expect($('[flash]').getText()).to.eventually.equal('Account successfully created')
    .then -> callback()
