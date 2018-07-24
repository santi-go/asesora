const expect = require('chai').expect
const assert = require('chai').assert
const Solicitude = require('./page-object/solicitude')
const SolicitudeShow = require('./page-object/solicitude-show')
const SolicitudesList = require('./page-object/solicitudes-list')
const Fixtures = require('./fixtures')


describe('Solicitude', () => {
  before(function(){
    fixtures = new Fixtures()
    fixtures.clean()
  })

  afterEach(function(){
    fixtures = new Fixtures()
    fixtures.clean()
  })

  it("allows to edit after passing through show solicitude", () => {
    const DATE_SPANISH = '02-11-2018'
    const DATE_ENGLISH = '2018-02-11'
    const TEXT = 'Solicitude text'
    const APPLICANT_NAME = 'John'
    const APPLICANT_SURNAME = 'Doe'
    const APPLICANT_EMAIL = 'john@doe.com'
    const APPLICANT_PHONENUMBER = '987654321'
    const COMPANY_NAME = 'Company'
    const COMPANY_CIF = 'A98005978'
    const COMPANY_EMPLOYEES = '34'
    const COMPANY_CNAE = '931'
    const solicitude = new Solicitude()

    solicitude.fill()
      .date(DATE_SPANISH)
      .description(TEXT)
      .applicantName(APPLICANT_NAME)
      .applicantSurname(APPLICANT_SURNAME)
      .applicantEmail(APPLICANT_EMAIL)
      .applicantPhonenumber(APPLICANT_PHONENUMBER)
      .companyName(COMPANY_NAME)
      .companyCif(COMPANY_CIF)
      .companyEmployees(COMPANY_EMPLOYEES)
      .lostFocus()
    solicitude.submit()

    const solicitudesList = new SolicitudesList()
    solicitudesList.clickOnShowButtonOnItem(1)

    const solicitudeShow = new SolicitudeShow()

    solicitudeShow.clickOnEditButton()

    solicitude.waitForSolicitude()

    assert(solicitude.isDeleteSolicitudeButtonVisible(), true)

    expect(solicitude.applicantNameValue()).to.eq(APPLICANT_NAME)
  })
})
