const expect = require('chai').expect
const Solicitude = require('./page-object/solicitude')
const SolicitudesList = require('./page-object/solicitudes-list')
const Fixtures = require('./fixtures')

describe('Solicitude List', () => {
  before(() => {
    this.fixtures = new Fixtures()
    this.fixtures.pristine()
  })

  it ('can be populated', () => {
    const applicant = this.fixtures.fullName()

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

})
