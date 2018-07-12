exports.config = {
  specs: [
    './test/e2e/solicitude_test.js'
  ],
  maxInstances: 1,
  host: 'selenium',
  port: 4444,
  baseUrl: 'http://asesora',
  capabilities: [{
    browserName: 'chrome'
  }],
  reporters: ['spec'],
  framework: 'mocha',
  mochaOpts: {
    timeout: 20000
  }
}
