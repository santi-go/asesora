const expect = require('chai').expect
const assert = require('chai').assert
const Solicitude = require('./page-object/solicitude')
const SolicitudesList = require('./page-object/solicitudes-list')
const Fixtures = require('./fixtures')


describe('Solicitude Edition', () => {
  before(function(){
    fixtures = new Fixtures()
    fixtures.clean()
  })

  afterEach(function(){
    fixtures = new Fixtures()
    fixtures.clean()
  })

  it("edits solicitude data", () => {
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
      .companyCnae(COMPANY_CNAE)
      .lostFocus()
    solicitude.submit()

    const solicitudesList = new SolicitudesList()
    solicitudesList.clickOnListItem()

    solicitude.waitForSolicitude()
    solicitude.waitForCompanyName()

    solicitude.fill()
              .companyName('Other Company')
              .lostFocus()

    solicitude.clickOnSaveCompany()

    solicitude.waitForSolicitude()

    expect(solicitude.applicantNameValue()).to.eq(APPLICANT_NAME)
    expect(solicitude.applicantSurnameValue()).to.eq(APPLICANT_SURNAME)
    expect(solicitude.applicantEmailValue()).to.eq(APPLICANT_EMAIL)
    expect(solicitude.applicantPhonenumberValue()).to.eq(APPLICANT_PHONENUMBER)
    expect(solicitude.companyNameValue()).to.not.eq(COMPANY_NAME)
    expect(solicitude.companyCifValue()).to.eq(COMPANY_CIF)
    expect(solicitude.companyEmployeesValue()).to.eq(COMPANY_EMPLOYEES)
    expect(solicitude.companyCnaeValue()).to.eq(COMPANY_CNAE)
    expect(solicitude.textValue()).to.eq(TEXT)
    expect(solicitude.dateValue()).to.eq(DATE_ENGLISH)
  })

  it("shows delete solicitude button", function(){
    const solicitude = new Solicitude()
    solicitude.fill()
              .applicantName()
              .applicantPhonenumber()
              .description()
    solicitude.submit()

    const solicitudesList = new SolicitudesList()

    solicitudesList.waitForSolicitudesList()

    solicitudesList.clickOnListItem()

    solicitude.waitForSolicitude()

    assert(solicitude.isDeleteSolicitudeButtonVisible(), true)
  })

  describe ("when editing a company", function() {
    it ("shows a notification when the company is related with only ONE solicitude", () => {

      const solicitude = new Solicitude()
      solicitude.fill()
                .applicantName()
                .applicantPhonenumber()
                .description()
                .companyName('Empresa 1')
                .companyCif('W1626268E')
      solicitude.submit()

      const solicitudesList = new SolicitudesList()
      solicitudesList.waitForSolicitudesList()

      solicitudesList.clickOnListItem()
      solicitude.waitForSolicitude()
      solicitude.waitForAlertEditCompany()

      assert(solicitude.isEditCompanyAlertVisible(), true)
    })

    it ("shows edit company button when the company is related to two solicitudes", () => {
      const firstSolicitude = new Solicitude()
      firstSolicitude.fill()
                .applicantName("First")
                .applicantPhonenumber("555333111")
                .description()
                .companyName('Empresa 1')
                .companyCif('W1626268E')
      firstSolicitude.submit()

      const secondSolicitude = new Solicitude()
      secondSolicitude.fill()
                .applicantName("Second")
                .applicantPhonenumber("111555333")
                .description()
                .companyName('Empresa 1')
                .companyCif('W1626268E')
      secondSolicitude.submit()

      const solicitudesList = new SolicitudesList()

      solicitudesList.waitForSolicitudesList()
      solicitudesList.clickOnListItem()

      secondSolicitude.waitForSolicitude()

      assert(secondSolicitude.isEditCompanyButtonVisible(), true)
    })

    context('when the company is related to more than one solicitude when is modifing company', () => {

      context('and add value button is clicked', () => {

        it ("shows added employees value message", () => {
          const firstSolicitude = new Solicitude()
          firstSolicitude.fill()
                    .applicantName("First")
                    .applicantPhonenumber("555333111")
                    .description()
                    .companyName('Empresa 1')
                    .companyCif('W1626268E')
          firstSolicitude.submit()
          const secondSolicitude = new Solicitude()
          secondSolicitude.fill()
                    .applicantName("Second")
                    .applicantPhonenumber("111555333")
                    .description()
                    .companyName('Empresa corregida')
                    .companyCif('W1626268E')
          secondSolicitude.submit()
          const solicitudesList = new SolicitudesList()

          solicitudesList.waitForSolicitudesList()
          solicitudesList.clickOnListItem()

          secondSolicitude.waitForSolicitude()

          secondSolicitude.clickOnEditCompany()
          assert(secondSolicitude.isAddEmployeesValueButtonVisible(), true)

          secondSolicitude.clickOnAddEmployeesValueButton()
          assert(secondSolicitude.isAddedEmployeesValueVisible(), true)
        })

        it ("shows added name value message", () => {
          const firstSolicitude = new Solicitude()
          firstSolicitude.fill()
                    .applicantName("First")
                    .applicantPhonenumber("555333111")
                    .description()
                    .companyName('Empresa 1')
                    .companyCif('W1626268E')
          firstSolicitude.submit()
          const secondSolicitude = new Solicitude()
          secondSolicitude.fill()
                    .applicantName("Second")
                    .applicantPhonenumber("111555333")
                    .description()
                    .companyName('Empresa corregida')
                    .companyCif('W1626268E')
          secondSolicitude.submit()
          const solicitudesList = new SolicitudesList()
          browser.waitForVisible('#solicitudes-list', 2000)
          solicitudesList.clickOnListItem()
          browser.waitForVisible('#solicitude', 2000)

          secondSolicitude.clickOnEditCompany()
          assert(secondSolicitude.isAddNameValueButtonVisible(), true)

          secondSolicitude.clickOnAddNameValueButton()
          assert(secondSolicitude.isAddedNameValueVisible(), true)
        })
      })
    })
  })
})
