clearDatabase = (env) ->
  support = require '../support/support.coffee'
  request = support().request
  token = support().token

  # Delete test data, used as proof-of-concept
  request.del "https://tracka-keepa-#{env}.firebaseio.com/users/test.json?auth=#{token}"

module.exports = ->

  # After each scenario, run this hook
  @After (callback) ->
    firebaseEnv = process.env.FIREBASE_ENV

    # Uncomment this when looking to clear real data
    # clearDatabase firebaseEnv
    callback()