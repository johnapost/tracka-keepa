gulp = require 'gulp'
newer = require 'gulp-newer'
cached = require 'gulp-cached'
inheritance = require 'gulp-jade-inheritance'
debug = require 'gulp-debug'
jade = require 'gulp-jade'
chmod = require 'gulp-chmod'
filter = require 'gulp-filter'
rename = require 'gulp-rename'
config = require './config.coffee'
plumber = require 'gulp-plumber'
notify = require 'gulp-notify'

errorAlert = (error) ->
  notify.onError(
    title: 'Jade Error'
    message: 'Check your terminal!'
  )(error)
  console.log error.toString()
  this.emit 'end'

gulp.task 'jade', ->
  gulp.src 'src/**/*.jade'
    .pipe plumber errorHandler: errorAlert
    .pipe newer dest: config.path, ext: '.html'

    .pipe cached 'jade'
    .pipe inheritance basedir: 'src'
    .pipe debug title: 'processed jade'
    .pipe filter (file) ->
      /views/.test file.path

    .pipe jade()
    .pipe chmod(755)

    .pipe rename (file) ->
      file.dirname = file.dirname.replace('views', '')
    .pipe gulp.dest config.path

module.exports = gulp