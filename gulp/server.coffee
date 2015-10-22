gulp = require 'gulp'
browserSync = require 'browser-sync'
config = require './config.coffee'
argv = require('yargs').argv
nodemon = require 'gulp-nodemon'

server = ->
  browserSync
    server: {baseDir: config.path}
    port: 4000
    open: false
    reloadOnRestart: false
    notify: false
    ghostMode: argv.ghost || false

  gulp.watch 'src/**/*.scss', ['sass']

  if argv.bdd
    gulp.watch(
      'src/**/*.coffee',
      [['coffee', 'protractor'],
      browserSync.reload]
    )
    gulp.watch 'src/**/*.jade', [['jade', 'protractor'], browserSync.reload]
    gulp.watch(
      ['features/**/*.coffee', 'features/**/*.feature'],
      [['protractor'], browserSync.reload]
    )
  else
    gulp.watch 'src/**/*.coffee', ['coffee', browserSync.reload]
    gulp.watch 'src/**/*.jade', ['jade', browserSync.reload]

gulp.task 'api', ->
  nodemon
    script: 'server/server.js'
    ext: 'coffee'
    ignore: ['src/*', 'gulp/*', 'gulpfile.coffee', 'tests/*']

gulp.task 'serve', [
    'vendor',
    'jade',
    'sass',
    'coffee',
    'images',
    'api'
  ], -> server()

module.exports = gulp
