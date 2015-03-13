module.exports = ->
  support = require '../support/support.coffee'
  expect = support().expect

  email = element By.css('#email')
  password = element By.css('#password')
  submit = element By.css('#submit')

  @When 'I visit the homepage', (callback) ->
    browser.get '/'
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
    expect element(By.css('.dashboard').getText()).to.eventually.equal 'Dashboard'
    .then -> callback()

  @Then 'I should see an error message', (callback) ->
    expect element(By.css('.error').getText()).to.eventually.equal 'Error'
    .then -> callback()
