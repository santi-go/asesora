const expect = require('chai').expect
const assert = require('chai').assert
const Solicitude = require('./page-object/solicitude')
const Fixtures = require('./fixtures')

describe('Solicitude', () => {
  beforeEach(function(){
    fixtures = new Fixtures()
    fixtures.clean()
  })

  it ("can be created", () => {
    const solicitude = new Solicitude()

    solicitude.fill()

    solicitude.lostFocus()

    expect(solicitude.isSubmitEnabled()).to.eq(true)
  })

  it ("hides date info when is not needed", () => {
    const solicitude = new Solicitude()

    solicitude.fillDate()
    solicitude.lostFocus()

    expect(solicitude.isDateInfoHiden()).to.eq(true)
  })

  it ("knows when the date is invalid", () => {
    const solicitude = new Solicitude()
    solicitude.fillDate()
    assert(solicitude.isDateInfoHiden(), true)
    solicitude.lostFocus()

    solicitude.fillWrongDate()
    solicitude.lostFocus()

    expect(solicitude.isDateInfoHiden()).to.eq(false)
  })

  it ("can be created with phone number and email", () => {
    const solicitude = new Solicitude()

    solicitude.fillApplicantPhonenumber()
    solicitude.fillApplicantEmail()
    solicitude.fillText()

    solicitude.lostFocus()

    expect(solicitude.isSubmitEnabled()).to.eq(true)
  })

})
