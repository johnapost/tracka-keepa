# Dependencies
gulp = require 'gulp'
del = require 'del'
runSequence = require 'run-sequence'
config = require './gulp/config.coffee'
argv = require('yargs').argv

# Cleans your output directory
gulp.task 'del', ->
  del config.path, force: true

# Move static files into dist
require './gulp/static.coffee'

# Process SASS
require './gulp/sass.coffee'

# Process CoffeeScript
require './gulp/coffee.coffee'

# Process Jade
require './gulp/jade.coffee'

# Process Images
require './gulp/images.coffee'

# Tests
# require './gulp/test.coffee'

# Server
require './gulp/server.coffee'

gulp.task 'default', [
  'vendor',
  'jade',
  'sass',
  'coffee',
  'images',
  'api',
  'serve'
]

gulp.task 'deploy', [
  'vendor',
  'jade',
  'sassProduction',
  'coffeeProduction',
  'imagesProduction'
]