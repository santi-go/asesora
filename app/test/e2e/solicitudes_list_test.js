const expect = require('chai').expect
const Solicitude = require('./page-object/solicitude')
const SolicitudesList = require('./page-object/solicitudes-list')
const Fixtures = require('./fixtures')

let fixtures = new Fixtures()

describe('Solicitude List', () => {
  before(() => {
    fixtures.pristine()
  })

  after(() => {
    fixtures.clean()
  })

  it ('can be populated with just applicant name', () => {
    const solicitude = new Solicitude()
    const applicantName = 'John'
    const applicant = applicantName

    solicitude.fill().required()
                    .applicantName(applicantName)
    solicitude.submit()

    const solicitudesList = new SolicitudesList()

    expect(solicitudesList.existApplicant(applicant)).to.be.true
  })

  it ('can be populated with applicant complete name', () => {
    const solicitudes = fixtures.solicitudes()
    const name = solicitudes[0]['applicant_name']
    const surname = solicitudes[0]['applicant_surname']

    const solicitudesList = new SolicitudesList()

    const applicantFullName = name + ' ' + surname
    expect(solicitudesList.existApplicant(applicantFullName)).to.be.true
  })

  it ('can be populated without applican', () => {
    const solicitude = new Solicitude()
    const solicitudeDate = "01/01/2018"
    solicitude.fill().required()
                     .date(solicitudeDate)
    solicitude.submit()

    const solicitudesList = new SolicitudesList()

    const notApplicant = "n/a"
    expect(solicitudesList.existNotApplicant(solicitudeDate, notApplicant)).to.be.true
  })

  it ('can be populated with company name', () => {
    const solicitudes = fixtures.solicitudes()
    const companyName = solicitudes[0]['company_name']

    const solicitudesList = new SolicitudesList()

    expect(solicitudesList.existCompanyName(companyName)).to.be.true
  })

  it ('can be populated without company', () => {
     const solicitude = new Solicitude()
     const applicantName = 'John'
     const notCompany = "n/a"
     const solicitudeDate = "03/03/2018"

     solicitude.fill().required()
                      .applicantName(applicantName)
                      .date(solicitudeDate)
     solicitude.submit()

     const solicitudesList = new SolicitudesList()
     browser.waitForVisible('#solicitudes-list', 2000)

     expect(solicitudesList.withoutCompany(solicitudeDate, notCompany)).to.be.true
   })
})
