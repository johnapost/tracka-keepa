mongoose = require 'mongoose'

switch process.env.ENVIRONMENT
  when 'DEVELOPMENT'
    mongoose.connect 'mongodb://localhost/trackakeepa', ->
      console.log 'mongodb connected'
  when 'STAGING'
    mongoose.connect process.env.MONGOLAB_URI, ->
      console.log 'mongolab connected'

module.exports = mongoose
