gulp = require 'gulp'
newer = require 'gulp-newer'
chmod = require 'gulp-chmod'
imagemin = require 'gulp-imagemin'
config = require './config.coffee'

gulp.task 'images', ->
  gulp.src 'src/images/**/*'
    .pipe newer "#{config.path}/images"

    .pipe chmod 755
    .pipe gulp.dest "#{config.path}/images"

gulp.task 'imagesProduction', ->
  gulp.src 'src/images/**/*'

    .pipe imagemin()
    .pipe chmod 755
    .pipe gulp.dest "#{config.path}/images"

module.exports = gulp