exports.config = {
  baseUrl: 'http://localhost:4001',
  seleniumAddress: 'http://localhost:4444/wd/hub',
  rootElement: 'body',

  params: {
    firebase_env: process.env.FIREBASE_ENV,
    login: {
      email: 'test@testaccount.com',
      password: 'testingisfun'
    }
  },

  capabilities: {
    'browserName': 'chrome'
  },

  framework: 'cucumber',
  specs: 'features/*.feature',

  cucumberOpts: {
    format: 'pretty'
  }
};