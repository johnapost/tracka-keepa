Post = require '../models/post'
User = require '../models/user'
router = require('express').Router()

router.get '/', (req, res) ->

  # Only authenticated users can use this route
  return res.sendStatus 401 unless req.headers['x-auth']

  Post.find().populate('_user').sort('-date').exec (err, posts) ->
    return next err if err
    res.json posts

router.post '/', (req, res, next) ->

  # Only authenticated users can use this route
  return res.sendStatus 401 unless req.headers['x-auth']

  post = new Post {
    _user: req.auth.userId
    body: req.body.body
  }

  post.save (err, post) ->
    return next err if err

    Post.findOne({'_id': post._id}).populate('_user').exec (err, post) ->
      return next err if err

      # Update all connected users
      socket = req.app.get 'socket'
      socket.sockets.emit 'post.created', post

      res.status(201).json post

module.exports = router
