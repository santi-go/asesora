const request = require('sync-request');

module.exports = class Fixtures {
  constructor() {
    this.fixtures = {}
  }

  solicitudes() {
    return this.fixtures
  }

  pristine() {
    const response = this.hit('pristine')
    this.fixtures = response['fixtures']
  }

  clean() {
    this.hit('clean')
    this.fixtures = {}
  }

  hit(endpoint) {
    var res = request('POST', 'http://api:4567/fixtures/' + endpoint)
    return JSON.parse(res.getBody())
  }
}
