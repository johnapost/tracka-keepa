module.exports = function(config) {
  config.set({
    basePath: '',

    frameworks: ['jasmine'],

    files: [
      'bower_components/modernizr/modernizr.js',
      'bower_components/jquery/dist/jquery.min.js',
      'bower_components/socket.io.client/dist/socket.io-1.3.5.js',
      'bower_components/angular/angular.min.js',
      'node_modules/angular-mocks/angular-mocks.js',
      'bower_components/angular-ui-router/release/angular-ui-router.min.js',
      'bower_components/angular-socket-io/socket.min.js',
      'bower_components/velocity/velocity.min.js',
      'bower_components/velocity/velocity.ui.min.js',
      'bower_components/bootstrap/dist/js/bootstrap.min.js',
      'node_modules/faker/build/build/faker.min.js',
      'src/**/*.coffee',
      'tests/**/*.coffee'
    ],

    exclude: [
    ],

    preprocessors: {
      '**/*.coffee': 'coffee',
      'src/**/*.coffee': 'coverage'
    },

    client: {
      captureConsole: true
    },

    reporters: ['progress', 'growl', 'coverage'],
    coverageReporter: {
      type: 'html',
      dir: 'coverage/'
    },

    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: true,
    browsers: ['Firefox'],

    singleRun: false
  });
};
