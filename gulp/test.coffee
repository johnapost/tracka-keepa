gulp = require 'gulp'
protractor = require('gulp-protractor').protractor

errorHandler = (error) ->
  console.log error.toString()
  this.emit 'end'

gulp.task 'protractor', [
    'vendor',
    'jade',
    'sass',
    'coffee',
    'images'
  ], ->
  gulp.src 'features/*.coffee'
    .pipe protractor configFile: 'test.js'
    .on 'error', errorHandler

module.exports = gulp