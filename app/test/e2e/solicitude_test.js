var expect = require('chai').expect
var Solicitude = require('./page-object/solicitude')

describe('Solicitude', () => {

  it ("can be created", () => {
    let solicitude = new Solicitude()

    solicitude.fillAplicant()

    solicitude.fillText()

    solicitude.lostFocus()

    expect(solicitude.isSubmitEnabled()).to.eq(true)
  })

  it ("hides date info when is not needed", () => {
    let solicitude = new Solicitude()

    solicitude.fillDate()

    expect(solicitude.isDateInfoHiden()).to.eq(true)
  })

  it ("knows when the date is invalid", () => {
    let solicitude = new Solicitude()

    solicitude.fillWrongDate()

    expect(solicitude.isDateInfoHiden()).to.eq(false)
  })


})