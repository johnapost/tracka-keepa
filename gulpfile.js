var gulp = require('gulp'),
  watch = require('gulp-watch'),
  del = require('del'),
  concat = require('gulp-concat'),
  uglify = require('gulp-uglify'),
  rename = require('gulp-rename'),
  sass = require('gulp-sass'),
  sourcemaps = require('gulp-sourcemaps'),
  prefix = require('gulp-autoprefixer'),
  minifycss = require('gulp-minify-css'),
  jade = require('gulp-jade'),
  coffee = require('gulp-coffee'),
  express = require('express'),
  merge = require('merge-stream'),
  livereload = require('gulp-livereload'),
  chmod = require('gulp-chmod'),
  changed = require('gulp-changed'),
  app = express()

gulp.task('del', function() {
  return del('dist')
})

gulp.task('sass', function() {
  return gulp.src('src/styles/app.scss')
    .pipe(changed('dist'))
    .pipe(sourcemaps.init())
      .pipe(sass({style: 'expanded'}))
      .on('error', errorHandler)
      .pipe(prefix('last 5 versions', '> 1%'))
      .pipe(minifycss)
    .pipe(sourcemaps.write())
    .pipe(rename('app.css'))
    .pipe(chmod(755))
    .pipe(gulp.dest('dist'))
})

gulp.task('coffee', function() {
  return gulp.src('src/scripts/**/*.coffee')
    .pipe(changed('dist/scripts'))
    .pipe(sourcemaps.init())
      .pipe(coffee({bare: true}))
      .on('error', errorHandler)
      .pipe(concat('app.coffee'))
    .pipe(sourcemaps.write())
    .pipe(rename('app.js'))
    .pipe(chmod(755))
    .pipe(gulp.dest('dist'))
})

gulp.task('jade', function() {
  return gulp.src('src/views/**/*.jade')
    .pipe(changed('dist'))
    .pipe(jade({pretty: true}))
    .on('error', errorHandler)
    .pipe(chmod(755))
    .pipe(gulp.dest('dist'))
})

gulp.task('reload', ['jade', 'coffee', 'sass'], function() {
  livereload.changed();
  console.log('LiveReload triggered.')
})

gulp.task('express', function() {
  app.use(express.static(__dirname + '/dist'));
  app.listen(4000);
})

gulp.task('watch', function() {
  livereload.listen();
  gulp.watch('src/**/*.coffee', ['coffee', 'reload'])
  gulp.watch('src/**/*.scss', ['sass', 'reload'])
  gulp.watch('src/**/*.jade', ['jade', 'reload'])
})

function errorHandler(err) {
  console.log(err.toString())
  this.emit('end')
}

gulp.task('default', [
  'jade',
  'sass',
  'coffee',
  'express',
  'watch',
])