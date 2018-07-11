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

  it ('is populated with applicant and company', () => {
    const solicitudes = fixtures.solicitudes()
    const solicitude = solicitudes[0]
    const name = solicitudes[0]['applicant_name']
    const surname = solicitudes[0]['applicant_surname']
    const company = solicitudes[0]['company_name']

    const solicitudesList = new SolicitudesList()

    const applicantFullName = name + ' ' + surname
    expect(solicitudesList.existApplicant(applicantFullName)).to.be.true
    expect(solicitudesList.existCompanyName(company)).to.be.true
  })
})
