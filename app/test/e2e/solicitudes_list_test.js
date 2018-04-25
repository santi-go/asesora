const expect = require('chai').expect
const Solicitude = require('./page-object/solicitude')
const SolicitudesList = require('./page-object/solicitudes-list')

describe('Solicitude List', () => {

  it ('can be populated', () => {
    const solicitude = new Solicitude()
    const applicantName = 'An applicant name'
    solicitude.fill().withApplicantName(applicantName).submit()

    const solicitudesList = new SolicitudesList()

    expect(solicitudesList.existApplicant(applicantName)).to.be.true
  })

})