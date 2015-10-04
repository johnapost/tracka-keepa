jwt = require 'jwt-simple'
config = require './config'

auth = (req, res, next) ->
  if req.headers['x-auth']
    req.auth = jwt.decode req.headers['x-auth'], config.secret

  next()

module.exports = auth
