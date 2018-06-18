const expect = require('chai').expect
const assert = require('chai').assert
const Solicitude = require('./page-object/solicitude')
const SolicitudesList = require('./page-object/solicitudes-list')
const Fixtures = require('./fixtures')


describe('Delete solicitude', () => {
  before(function(){
    fixtures = new Fixtures()
    fixtures.clean()
  })

  afterEach(function(){
    fixtures = new Fixtures()
    fixtures.clean()
  })


  it ("deletes a solicitude", () => {
    const solicitude = new Solicitude()
    solicitude.fill()
              .applicantName("First")
              .applicantPhonenumber("555333111")
              .description()
              .companyName('Empresa 1')
              .companyCif('W1626268E')
    solicitude.submit()

    const solicitudesList = new SolicitudesList()

    browser.waitForVisible('#solicitudes-list', 2000)

    solicitudesList.clickOnListItem(1)

    browser.waitForVisible('#solicitude', 2000)

    assert(solicitude.isDeleteSolicitudeButtonVisible(), true)
    solicitude.clickOnDeleteSolicitude()

    solicitude.acceptAlert()
    let numberOfSolicitudes = solicitudesList.numberOfSolicitudes()
    expect(numberOfSolicitudes).to.eq(0)
  })
})
