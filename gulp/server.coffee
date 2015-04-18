gulp = require 'gulp'
browserSync = require 'browser-sync'
config = require './config.coffee'

gulp.task 'serve', [
    'vendor',
    'jade',
    'sass',
    'coffee',
    'images'
  ], ->
  browserSync
    server: {baseDir: config.path}
    port: 4000
    open: false
    reloadOnRestart: false
    notify: false

  gulp.watch 'src/**/*.scss', ['sass']
  gulp.watch 'src/**/*.coffee', [['coffee', 'protractor'], browserSync.reload]
  gulp.watch 'src/**/*.jade', [['jade', 'protractor'], browserSync.reload]

module.exports = gulp