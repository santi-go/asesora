exports.config = {
  specs: [
    './test/e2e/**/*.js'
  ],
  maxInstances: 1,
  host: 'selenium',
  port: 4444,
  baseUrl: 'http://asesora',
  capabilities: [{
    browserName: 'chrome'
  }],
  reporters: ['spec']
}
