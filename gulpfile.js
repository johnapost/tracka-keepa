// Call dependencies
var gulp = require('gulp'),
  watch = require('gulp-watch'),
  del = require('del'),
  concat = require('gulp-concat'),
  uglify = require('gulp-uglifyjs'),
  rename = require('gulp-rename'),
  sass = require('gulp-sass'),
  sourcemaps = require('gulp-sourcemaps'),
  prefix = require('gulp-autoprefixer'),
  minifycss = require('gulp-minify-css'),
  uncss = require('gulp-uncss')
  jade = require('gulp-jade'),
  coffee = require('gulp-coffee'),
  imagemin = require('gulp-imagemin'),
  merge = require('merge-stream'),
  runSequence = require('run-sequence'),
  browserSync = require('browser-sync'),
  reload = browserSync.reload,
  chmod = require('gulp-chmod'),
  changed = require('gulp-changed')

// Define your path
path = 'dist'


// Cleans your output directory
gulp.task('del', function() {
  return del(path, {force: true})
})


// Move static files into dist
gulp.task('fonts', function() {
  return gulp.src('src/brand/fonts/**/*')
    .pipe(changed(path + '/fonts'))
    .pipe(chmod(755))
    .pipe(gulp.dest(path + '/fonts'))
})


// Process SASS
gulp.task('sass', function() {
  return gulp.src('src/brand/app.scss')
    .pipe(changed(path + '/styles'))
    .pipe(sourcemaps.init())
      .pipe(sass({style: 'expanded'}))
      .on('error', errorHandler)
      .pipe(prefix({browsers: ['> 1%', 'last 2 versions', 'Firefox ESR', 'Opera 12.1']}))
      .pipe(rename('styles.css'))
      .pipe(chmod(755))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest(path + '/styles'))
    .pipe(reload({stream: true}))
})

gulp.task('sassProduction', function() {
  return gulp.src('src/brand/app.scss')
    .pipe(changed(path + '/styles'))
    .pipe(sass({style: 'expanded'}))
    .on('error', errorHandler)
    .pipe(prefix({browsers: ['> 1%', 'last 2 versions', 'Firefox ESR', 'Opera 12.1']}))
    .pipe(minifycss())
    .pipe(rename('styles.min.css'))
    .pipe(chmod(755))
    .pipe(gulp.dest(path + '/styles'))
})


// Process CoffeeScript
gulp.task('coffee', function() {
  return gulp.src('src/**/*.coffee')
    .pipe(changed(path + '/scripts'))

    .pipe(sourcemaps.init())
      .pipe(coffee({bare: true}))
      .on('error', errorHandler)
      .pipe(concat('app.js'))
      .pipe(chmod(755))
    .pipe(sourcemaps.write())

    .pipe(gulp.dest(path + '/scripts'))
})

gulp.task('coffeeProduction', function() {
  return gulp.src('src/**/*.coffee')
    .pipe(changed(path + '/scripts'))

    .pipe(coffee({bare: true}))
    .on('error', errorHandler)
    .pipe(concat('app.min.js'))
    .pipe(uglify())
    .pipe(chmod(755))

    .pipe(gulp.dest(path + '/scripts'))
})


// Process Jade
gulp.task('jade', function() {
  return gulp.src('src/views/**/*.jade')
    .pipe(changed(path))
    .pipe(jade({pretty: true})

    .on('error', errorHandler)
    .pipe(chmod(755))

    .pipe(gulp.dest(path))
})


// Process Images
gulp.task('images', function() {
  return gulp.src('src/brand/images/**/*')
    .pipe(changed(path + '/images'))
    .pipe(chmod(755))
    .pipe(gulp.dest(path + '/images'))
})

gulp.task('imagesProduction', function() {
  return gulp.src('src/brand/images/**/*')
    .pipe(changed(path + '/images'))
    .pipe(imagemin())
    .pipe(chmod(755))
    .pipe(gulp.dest(path + '/images'))
})


// Server
gulp.task('serve', function() {
  browserSync({
    server: {
      baseDir: servePath
    },
    port: 4000,
    open: false,
    reloadOnRestart: false,
    notify: false
  })

  gulp.watch('src/**/*.scss', ['sass'])
  gulp.watch('src/**/*.coffee', ['coffee', reload])
  gulp.watch('src/**/*.jade', ['jade', reload])
})

function errorHandler(err) {
  console.log(err.toString())
  this.emit('end')
}


// Prepares production-ready files
gulp.task('production', function() {
  runSequence(['sassProduction', 'coffeeProduction', 'imagesProduction'])
})

// Set up local server
gulp.task('default', [
  'jade',
  'sass',
  'grid',
  'coffee',
  'fonts',
  'images',
  'serve'
])