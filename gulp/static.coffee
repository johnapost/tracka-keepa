gulp = require 'gulp'
changed = require 'gulp-changed'
concat = require 'gulp-concat'
merge = require 'merge-stream'
uglify = require 'gulp-uglifyjs'
minifycss = require 'gulp-minify-css'
config = require './config.coffee'

gulp.task 'vendor', ->
  js = gulp.src [
    'bower_components/modernizr/modernizr.js'
    'bower_components/jquery/dist/jquery.min.js'
    'bower_components/angular/angular.min.js'
    'bower_components/angular-aria/angular-aria.min.js'
    'bower_components/angular-animate/angular-animate.min.js'
    'bower_components/angular-material/angular-material.min.js'
    'bower_components/firebase/firebase.js'
    'bower_components/angularfire/dist/angularfire.min.js'
    'bower_components/mockfirebase/browser/mockfirebase.js'
  ]
  .pipe changed "#{config.path}/scripts"
  .pipe uglify()
  .pipe concat 'vendor.js'
  .pipe gulp.dest "#{config.path}/scripts"

  css = gulp.src [
    'bower_components/angular-material/angular-material.min.css'
  ]
  .pipe changed "#{config.path}/styles"
  .pipe minifycss keepSpecialComments: 0
  .pipe concat 'vendor.css'
  .pipe gulp.dest "#{config.path}/styles"

  merge js, css

module.exports = gulp