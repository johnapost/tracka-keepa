gulp = require 'gulp'
changed = require 'gulp-changed'
concat = require 'gulp-concat'
merge = require 'merge-stream'
uglify = require 'gulp-uglifyjs'
minifycss = require 'gulp-minify-css'
config = require './config.coffee'

gulp.task 'vendor', ->
  js = gulp.src [
    'bower_components/modernizr/modernizr.js',
    'bower_components/jquery/dist/jquery.min.js',
    'bower_components/bootswatch-dist/js/bootstrap.min.js',
    'bower_components/angular/angular.min.js',
    'bower_components/firebase/firebase.js',
    'bower_components/angularfire/dist/angularfire.min.js'
  ]
  .pipe changed "#{config.path}/scripts"
  .pipe uglify()
  .pipe concat 'vendor.js'
  .pipe gulp.dest "#{config.path}/scripts"

  css = gulp.src [
    'bower_components/bootswatch-dist/css/bootstrap.min.css'
  ]
  .pipe changed "#{config.path}/styles"
  .pipe minifycss()
  .pipe concat 'vendor.css'
  .pipe gulp.dest "#{config.path}/styles"

  merge js, css

module.exports = gulp