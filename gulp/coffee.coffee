gulp = require 'gulp'
cache = require 'gulp-cached'
debug = require 'gulp-debug'
newer = require 'gulp-newer'
remember = require 'gulp-remember'
sourcemaps = require 'gulp-sourcemaps'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
chmod = require 'gulp-chmod'
uglify = require 'gulp-uglifyjs'
config = require './config.coffee'

errorHandler = (error) ->
  console.log error.toString()
  this.emit 'end'

gulp.task 'coffee', ->
  gulp.src 'src/**/*.coffee'
    .pipe newer "#{config.path}/styles/app.css"
    .pipe sourcemaps.init()

    .pipe coffee(bare: true)
    .on 'error', errorHandler
    .pipe remember 'coffee'
    .pipe concat('app.js')
    .pipe chmod(755)

    .pipe sourcemaps.write()
    .pipe gulp.dest("#{config.path}/scripts")

gulp.task 'coffeeProduction', ->
  gulp.src 'src/**/*.coffee'
    .pipe newer "#{config.path}/styles/app.css"

    .pipe coffee(bare: true)
    .on 'error', errorHandler
    .pipe remember 'coffee'
    .pipe concat('app.js')
    .pipe uglify()
    .pipe chmod(755)

    .pipe gulp.dest("#{config.path}/scripts")

module.exports = gulp