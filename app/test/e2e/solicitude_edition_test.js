const expect = require('chai').expect
const assert = require('chai').assert
const Solicitude = require('./page-object/solicitude')
const SolicitudesList = require('./page-object/solicitudes-list')
const Fixtures = require('./fixtures')


describe('Solicitude Edition', () => {
  beforeEach(function(){
    fixtures = new Fixtures()
    fixtures.clean()
  })

  it ("shows an alert when edit company button is clicked", () => {
    const solicitude = new Solicitude()
    solicitude.fill()
              .applicantName()
              .applicantPhonenumber()
              .description()
    solicitude.submit()

    const solicitudesList = new SolicitudesList()

    solicitudesList.clickOnListItem()

    solicitude.clickOnEditCompany()

    assert(solicitude.isEditCompanyAlertVisible(), true)

  })

  it ("hides the alert when save button is clicked", () => {
    const solicitude = new Solicitude()
    solicitude.fill()
              .applicantName()
              .applicantPhonenumber()
              .description()
    solicitude.submit()

    const solicitudesList = new SolicitudesList()

    solicitudesList.clickOnListItem()

    solicitude.clickOnEditCompany()

    assert(solicitude.isEditCompanyAlertVisible(), true)

    solicitude.fill()
              .companyName('Empresa 1')
              .companyCif('W1626268E')
              .clickOnSaveCompany()

    assert(solicitude.isEditCompanyAlertVisible(), false)
  })

})
