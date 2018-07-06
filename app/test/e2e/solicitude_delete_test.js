const expect = require('chai').expect
const assert = require('chai').assert
const Solicitude = require('./page-object/solicitude')
const SolicitudesList = require('./page-object/solicitudes-list')
const Fixtures = require('./fixtures')

let fixtures = new Fixtures()

describe('Delete solicitude', () => {
  before(function(){
    fixtures.pristine()
  })

  afterEach(function(){
    fixtures.clean()
  })

  it ("deletes a solicitude", () => {
    const solicitudesList = new SolicitudesList()
    browser.waitForVisible('#solicitudes-list', 2000)
    browser.scroll('#solicitudes-list')
    const solicitude = solicitudesList.clickOnEditButtonOnItem(1)
    browser.waitForVisible('#solicitude', 2000)
    browser.scroll('#solicitude')
    assert(solicitude.isDeleteSolicitudeButtonVisible(), true)

    solicitude.clickOnDeleteSolicitude()
    solicitude.acceptAlert()

    const numberOfSolicitudes = solicitudesList.numberOfSolicitudes()
    const expectedNumberOfSolicitudes = fixtures.solicitudes().length - 1
    expect(numberOfSolicitudes).to.eq(expectedNumberOfSolicitudes)
  })
})
