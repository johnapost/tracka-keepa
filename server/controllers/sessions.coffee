User = require '../models/user'
router = require('express').Router()
bcrypt = require 'bcrypt'
jwt = require 'jwt-simple'
config = require '../config'

router.post '/', (req, res, next) ->
  User.findOne username: req.body.username
    .select 'password'
    .select 'username'
    .exec (err, user) ->
      return next err if err
      return res.sendStatus 401 unless user
      bcrypt.compare req.body.password, user.password, (err, valid) ->
        return next err if err
        return res.sendStatus 401 unless valid
        token = jwt.encode userId: user._id, config.secret
        res.json token

module.exports = router
