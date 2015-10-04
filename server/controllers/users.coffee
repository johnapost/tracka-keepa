User = require '../models/user'
router = require('express').Router()
bcrypt = require 'bcrypt'
jwt = require 'jwt-simple'
config = require '../config'

router.get '/', (req, res, next) ->

  # Only authenticated users can use this route
  return res.sendStatus 401 unless req.headers['x-auth']

  auth = jwt.decode req.headers['x-auth'], config.secret
  User.findOne _id: auth.userId, (err, user) ->
    return next err if err
    res.json user

router.post '/', (req, res, next) ->
  user = new User username: req.body.username

  bcrypt.hash req.body.password, 10, (err, hash) ->
    return next err if err
    user.password = hash
    user.save (err) ->
      return next err if err
      res.sendStatus 201

module.exports = router
