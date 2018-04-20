const expect = require('chai').expect
const SolicitudesEdition = require('./page-object/solicitudes-edition')

describe('Solicitude Edition', () => {
  it ("knows when fields are correctly filled", () => {
    const solicitude = new SolicitudesEdition()

    solicitude.fillAplicant()
    solicitude.fillText()
    solicitude.fillDate()
    solicitude.lostFocus()

    expect(solicitude.isSubmitEnabled()).to.eq(true)
  })
})

describe('Solicitude Edition', () => {
  it ("knows when fields are not correctly filled", () => {
    const solicitude = new SolicitudesEdition()
    solicitude.acceptAlert()
    

    solicitude.fillAplicant()
    solicitude.fillText()
    solicitude.fillWrongDate()
    solicitude.lostFocus()

    expect(solicitude.isSubmitEnabled()).to.eq(false)
  })
})
