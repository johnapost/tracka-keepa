module.exports = ->
  # Refactor this out to a support file
  chai = require 'chai'
  chaiAsPromised = require 'chai-as-promised'
  chai.use chaiAsPromised
  expect = chai.expect

  this.When 'I visit the homepage', (callback) ->
    browser.get '/'
    callback()

  this.Then 'I should see the page title', (callback) ->
    browser.getTitle().then (title) ->
      expect(title).to.equal 'Tracka Keepa'
      callback()