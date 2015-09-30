mongoose = require 'mongoose'

mongoose.connect 'mongodb://localhost/trackakeepa', ->
  console.log 'mongodb connected'

module.exports = mongoose
