express = require 'express'
http = require 'http'
socket = require 'socket.io'
bodyParser = require 'body-parser'
jwt = require 'jwt-simple'
bcrypt = require 'bcrypt'

allowCrossDomain = (req, res, next) ->
  # res.header 'Access-Control-Allow-Origin', 'http://localhost:4000'
  res.header 'Access-Control-Allow-Origin', '*'
  res.header 'Access-Control-Allow-Methods', 'GET, PUT, POST, DELETE'
  res.header 'Access-Control-Allow-Headers', ['Content-Type', 'X-Auth']
  next()

# Define App and Middleware
app = express()
app.use bodyParser.json()
app.use allowCrossDomain
app.use require './auth'

# Routes
app.use '/api/posts', require './controllers/posts'
app.use '/api/sessions', require './controllers/sessions'
app.use '/api/users', require './controllers/users'

# Start API server
server = http.createServer app
io = socket.listen server
app.set 'socket', io
app.set 'server', server
app.get('server').listen 3000, -> console.log 'Server listening on :3000'
