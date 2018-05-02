const expect = require('chai').expect
const Solicitude = require('./page-object/solicitude')
const SolicitudesList = require('./page-object/solicitudes-list')

describe('Solicitude List', () => {

  it ('can be populated', () => {
    const solicitude = new Solicitude()
    const applicantName = 'John'
    const applicant = applicantName

    solicitude.withApplicantName(applicantName)
    solicitude.fill().submit()

    const solicitudesList = new SolicitudesList()

    expect(solicitudesList.existApplicant(applicant)).to.be.true
  })

  it ('can be populated with complete name', () => {
    const solicitude = new Solicitude()
    const applicantName = 'John'
    const applicantSurname = 'Doe'
    const applicant = applicantName + " " + applicantSurname

    solicitude.withApplicantName(applicantName)
    solicitude.withApplicantSurname(applicantSurname)
    solicitude.fill().submit()

    const solicitudesList = new SolicitudesList()

    expect(solicitudesList.existApplicant(applicant)).to.be.true
  })

  it ('can be populated without complete name', () => {
    const solicitude = new Solicitude()
    const notApplicant = "n/a"
    const solicitudeDate = "01/01/2018"

    solicitude.fillDate(solicitudeDate)
    solicitude.fill().submit()

    const solicitudesList = new SolicitudesList()

    expect(solicitudesList.existNotApplicant(solicitudeDate, notApplicant)).to.be.true
  })

  it ('can be populated with company name', () => {
    const solicitude = new Solicitude()
    const solicitudeApplicantName = 'John'
    const solicitudeCompanyName = 'John Inc.'
    const solicitudeCompanyCif = 'A01316637'

    solicitude.fill()
    solicitude.withApplicantName(solicitudeApplicantName)
    solicitude.withCompanyName(solicitudeCompanyName)
    solicitude.withCompanyCif(solicitudeCompanyCif)
    solicitude.submit()

    const solicitudesList = new SolicitudesList()

    expect(solicitudesList.existCompanyName(solicitudeCompanyName)).to.be.true
  })

})
