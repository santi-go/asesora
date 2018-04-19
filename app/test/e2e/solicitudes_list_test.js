const expect = require('chai').expect
const Solicitude = require('./page-object/solicitude')
const SolicitudesList = require('./page-object/solicitudes-list')

describe('Solicitude List', () => {

  it ('can be populated', () => {
    const solicitude = new Solicitude()
    const applicant = 'An applicant name'
    solicitude.fill().withApplicant(applicant).submit()

    const solicitudesList = new SolicitudesList()

    expect(solicitudesList.existApplicant(applicant)).to.be.true
  })

})