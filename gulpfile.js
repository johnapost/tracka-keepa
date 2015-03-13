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
  cucumber = require('cucumber')
  protractor = require('gulp-protractor').protractor,
  app = express()

gulp.task('del', function() {
  return del('dist')
})

gulp.task('sass', function() {
  return gulp.src('src/app.scss')
    .pipe(changed('dist'))
    .pipe(sourcemaps.init())
      .pipe(sass({style: 'expanded'}))
      .on('error', errorHandler)
      .pipe(prefix('last 5 versions', '> 1%'))
      .pipe(minifycss())
    .pipe(sourcemaps.write())
    .pipe(rename('app.css'))
    .pipe(chmod(755))
    .pipe(gulp.dest('dist/styles'))
})

gulp.task('coffee', function() {
  return gulp.src('src/**/*.coffee')
    .pipe(sourcemaps.init())
      .pipe(coffee({bare: true}))
      .on('error', errorHandler)
      .pipe(concat('app.coffee'))
      .pipe(uglify())
    .pipe(sourcemaps.write())
    .pipe(rename('app.js'))
    .pipe(chmod(755))
    .pipe(gulp.dest('dist/scripts'))
})

gulp.task('jade', function() {
  return gulp.src('src/views/**/*.jade')
    .pipe(changed('dist'))
    .pipe(jade())
    .on('error', errorHandler)
    .pipe(chmod(755))
    .pipe(gulp.dest('dist'))
})

gulp.task('vendor', function() {
  var js = gulp.src([
    'bower_components/modernizr/modernizr.js',
    'bower_components/jquery/dist/jquery.min.js',
    'bower_components/jquery/dist/jquery.min.map',
    'bower_components/bootswatch-dist/js/bootstrap.min.js',
    'bower_components/angular/angular.min.js',
    'bower_components/angular/angular.min.js.map',
    'bower_components/firebase/firebase.js',
    'bower_components/angularfire/dist/angularfire.min.js'
  ])
  .pipe(changed('dist/scripts'))
  .pipe(gulp.dest('dist/scripts'))

  var css = gulp.src([
    'bower_components/bootswatch-dist/css/bootstrap.min.css'
  ])
  .pipe(changed('dist/styles'))
  .pipe(gulp.dest('dist/styles'))

  return merge(js, css)
})

gulp.task('reload', ['jade', 'coffee', 'sass', 'protractor'], function() {
  livereload.changed('');
  console.log('LiveReload triggered.')
})

gulp.task('express', function() {
  app.use(express.static(__dirname + '/dist'));
  app.listen(4000);
})

gulp.task('protractor', function() {
  return gulp.src('features/*.coffee')
    .pipe(protractor({
      configFile: 'test.js',
    }))
    .on('error', errorHandler)
})

gulp.task('watch', function() {
  livereload.listen();
  gulp.watch('src/**/*.coffee', ['coffee', 'reload', 'protractor'])
  gulp.watch('src/**/*.scss', ['sass', 'reload', 'protractor'])
  gulp.watch('src/**/*.jade', ['jade', 'reload', 'protractor'])
  gulp.watch(['features/**/*.feature', 'features/**/*.coffee'], ['protractor'])
})

function errorHandler(err) {
  console.log(err.toString())
  this.emit('end')
}

gulp.task('default', [
  'jade',
  'sass',
  'coffee',
  'vendor',
  'express',
  'protractor',
  'watch'
])