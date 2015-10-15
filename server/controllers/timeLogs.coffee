TimeLog = require '../models/timeLog'
User = require '../models/user'
router = require('express').Router()
jwt = require 'jwt-simple'
config = require '../config'

# Get all of a user's logs
router.get '/', (req, res, next) ->

  # Only authenticated users can use this route
  return res.sendStatus 401 unless req.headers['x-auth']

  TimeLog.find({_user: req.auth.userId}).sort('-stopTime')
    .exec (err, timeLogs) ->
      return next err if err
      res.json timeLogs

# Start a time log
router.post '/start', (req, res, next) ->

  # Only authenticated users can use this route
  return res.sendStatus 401 unless req.headers['x-auth']

  timeLog = new TimeLog {
    _user: req.auth.userId
    startTime: req.body.startTime
    stopTime: null
  }

  timeLog.save (err, timeLog) ->
    return next err if err
    TimeLog.findOne({_id: timeLog._id}).exec (err, timeLog) ->
      return next err if err
      res.status(201).json timeLog

# Stop a running time log
router.post '/stop', (req, res, next) ->

  # Only authenticated users can use this route
  return res.sendStatus 401 unless req.headers['x-auth']

  # Find the latest timeLog
  TimeLog.find({_user: req.auth.userId}).sort('-_id').limit(1)
    .exec (err, timeLogs) ->
      return next err if err
      timeLog = timeLogs[0]
      timeLog.stopTime = req.body.stopTime
      timeLog.save (err, timeLog) ->
        res.status(200).json timeLog

module.exports = router
