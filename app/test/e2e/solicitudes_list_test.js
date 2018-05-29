const expect = require('chai').expect
const Solicitude = require('./page-object/solicitude')
const SolicitudesList = require('./page-object/solicitudes-list')
const Fixtures = require('./fixtures')


describe('Solicitude List', () => {
  beforeEach(() => {
    this.fixtures = new Fixtures()
    this.fixtures.clean()
  })

 it ('can be populated', () => {
    const solicitude = new Solicitude()
    const applicantName = 'John'
    const applicant = applicantName

    solicitude.fill().required()
                     .applicantName(applicantName)
    solicitude.submit()

    const solicitudesList = new SolicitudesList()

    expect(solicitudesList.existApplicant(applicant)).to.be.true
  })

 it ('can be populated with complete name', () => {
    const solicitude = new Solicitude()
    const applicantName = 'John'
    const applicantSurname = 'Doe'
    const applicant = applicantName + " " + applicantSurname

    solicitude.fill().required()
                     .applicantName(applicantName)
                     .applicantSurname(applicantSurname)
    solicitude.submit()

    const solicitudesList = new SolicitudesList()

    expect(solicitudesList.existApplicant(applicant)).to.be.true
  })

 it ('can be populated without complete name', () => {
    const solicitude = new Solicitude()
    const notApplicant = "n/a"
    const solicitudeDate = "01/01/2018"

    solicitude.fill().required()
                     .date(solicitudeDate)
    solicitude.submit()

    const solicitudesList = new SolicitudesList()

    expect(solicitudesList.existNotApplicant(solicitudeDate, notApplicant)).to.be.true
  })

 it ('can be populated with company name', () => {
    const solicitude = new Solicitude()
    const solicitudeApplicantName = 'John'
    const solicitudeCompanyName = 'John Inc.'
    const solicitudeCompanyCif = '12345678Z'

    solicitude.fill().required()
                     .applicantName(solicitudeApplicantName)
                     .companyName(solicitudeCompanyName)
                     .companyCif(solicitudeCompanyCif)
    solicitude.submit()

    const solicitudesList = new SolicitudesList()

    expect(solicitudesList.existCompanyName(solicitudeCompanyName)).to.be.true
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

     expect(solicitudesList.withoutCompany(solicitudeDate, notCompany)).to.be.true
   })

})
