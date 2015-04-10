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
  changed = require('gulp-changed'),
  filter = require('gulp-filter'),
  argv = require('yargs').argv,
  protractor = require('gulp-protractor').protractor

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


// Process SASS
gulp.task('sass', function() {
  return gulp.src('src/app.scss')
    .pipe(changed(path + '/styles'))
    .pipe(sourcemaps.init())
      .pipe(sass({style: 'expanded'}))
      .on('error', errorHandler)
      .pipe(prefix({browsers: ['> 1%', 'last 2 versions', 'Firefox ESR', 'Opera 12.1']}))
      .pipe(rename('app.css'))
      .pipe(chmod(755))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest(path + '/styles'))
    .pipe(filter('**/*.css'))
    .pipe(reload({stream: true}))
})

gulp.task('sassProduction', function() {
  return gulp.src('src/app.scss')
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
    .pipe(jade({pretty: true}))

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
      baseDir: path
    },
    port: 4000,
    open: false,
    reloadOnRestart: false,
    notify: false,
    ghostMode: false
  })

  if (argv.bdd === true) {
    gulp.watch('src/**/*.scss', ['sass', 'protractor'])
    gulp.watch('src/**/*.coffee', ['coffee', 'protractor', reload])
    gulp.watch('src/**/*.jade', ['jade', 'protractor', reload])
  } else {
    gulp.watch('src/**/*.scss', ['sass'])
    gulp.watch('src/**/*.coffee', ['coffee', reload])
    gulp.watch('src/**/*.jade', ['jade', reload])
  }
})

function errorHandler(err) {
  console.log(err.toString())
  this.emit('end')
}


// Testing
gulp.task('protractor', function() {
  return gulp.src('features/*.coffee')
    .pipe(protractor({
      configFile: 'test.js',
    }))
    .on('error', errorHandler)
})


// Prepares production-ready files
gulp.task('production', function() {
  runSequence(['sassProduction', 'coffeeProduction', 'imagesProduction'])
})

// Set up local server
gulp.task('default', [
  'vendor',
  'jade',
  'sass',
  'coffee',
  'fonts',
  'images',
  'serve'
])