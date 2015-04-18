gulp = require 'gulp'
rename = require 'gulp-rename'
changed = require 'gulp-changed'
sourcemaps = require 'gulp-sourcemaps'
sass = require 'gulp-sass'
prefix = require 'gulp-autoprefixer'
minifycss = require 'gulp-minify-css'
chmod = require 'gulp-chmod'
filter = require 'gulp-filter'
browserSync = require 'browser-sync'
config = require './config.coffee'

errorHandler = (error) ->
  console.log error.toString()
  this.emit 'end'

gulp.task 'sass', ->
  gulp.src 'src/app.scss'
    .pipe changed("#{config.path}/styles", extension: '.css')
    .pipe sourcemaps.init()

    .pipe sass(style: 'expanded')
    .on 'error', errorHandler
    .pipe prefix(browsers: ['> 1%', 'last 2 versions', 'Firefox ESR', 'Opera 12.1'])
    .pipe minifycss()
    .pipe rename('app.css')
    .pipe chmod(755)

    .pipe sourcemaps.write()
    .pipe gulp.dest("#{config.path}/styles")
    .pipe filter('**/*.css')
    .pipe browserSync.reload(stream: true)