exports.config = {
  baseUrl: 'http://localhost:4000',
  seleniumAddress: 'http://localhost:4444/wd/hub',
  rootElement: 'body',

  capabilities: {
    'browserName': 'chrome'
  },

  framework: 'cucumber',
  specs: 'features/*.feature',

  cucumberOpts: {
    format: 'pretty'
  }
};