const expect = require('chai').expect
const SolicitudesEdition = require('./page-object/solicitudes-edition')
const Fixtures = require('./fixtures')


describe('Solicitude Edition', () => {
  beforeEach(function(){
    fixtures = new Fixtures()
    fixtures.clean()
  })
  
  it ("knows when fields are correctly filled", () => {
    const solicitude = new SolicitudesEdition()

    solicitude.fill().applicantName()
                     .description()
                     .date()
    solicitude.lostFocus()

    expect(solicitude.isSubmitEnabled()).to.eq(true)
  })

  it ("knows when fields are not correctly filled", () => {
    const solicitude = new SolicitudesEdition()

    solicitude.fill().applicantName()
                     .description()
                     .wrongDate()
    solicitude.lostFocus()

    expect(solicitude.isSubmitEnabled()).to.eq(false)
  })
})
