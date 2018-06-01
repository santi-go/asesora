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

  it ("retrieves all data", () => {
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

     solicitude.acceptAlert()
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
     solicitude.wait()

     expect(solicitude.applicantNameValue()).to.eq(APPLICANT_NAME)
     expect(solicitude.applicantSurnameValue()).to.eq(APPLICANT_SURNAME)
     expect(solicitude.applicantEmailValue()).to.eq(APPLICANT_EMAIL)
     expect(solicitude.applicantPhonenumberValue()).to.eq(APPLICANT_PHONENUMBER)
     expect(solicitude.companyNameValue()).to.eq(COMPANY_NAME)
     expect(solicitude.companyCifValue()).to.eq(COMPANY_CIF)
     expect(solicitude.companyEmployeesValue()).to.eq(COMPANY_EMPLOYEES)
     expect(solicitude.companyCnaeValue()).to.eq(COMPANY_CNAE)
     expect(solicitude.textValue()).to.eq(TEXT)
     expect(solicitude.dateValue()).to.eq(DATE_ENGLISH)
   })

})
