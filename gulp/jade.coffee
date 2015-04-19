gulp = require 'gulp'
changed = require 'gulp-changed'
cached = require 'gulp-cached'
inheritance = require 'gulp-jade-inheritance'
debug = require 'gulp-debug'
jade = require 'gulp-jade'
chmod = require 'gulp-chmod'
filter = require 'gulp-filter'
rename = require 'gulp-rename'
config = require './config.coffee'

errorHandler = (error) ->
  console.log error.toString()
  this.emit 'end'

gulp.task 'jade', ->
  gulp.src 'src/**/*.jade'
    .pipe changed config.path, extension: '.html'

    .pipe cached 'jade'
    .pipe inheritance basedir: 'src'
    .pipe debug title: 'processed jade'
    .pipe filter (file) ->
      /views/.test file.path

    .pipe jade()
    .on 'error', errorHandler
    .pipe chmod(755)

    .pipe rename (file) ->
      file.dirname = file.dirname.replace('views', '')
    .pipe gulp.dest config.path

module.exports = gulp