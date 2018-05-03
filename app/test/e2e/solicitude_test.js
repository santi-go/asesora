const expect = require('chai').expect
const assert = require('chai').assert
const Solicitude = require('./page-object/solicitude')

describe('Solicitude', () => {

  it ("can be created", () => {
    const solicitude = new Solicitude()

    solicitude.fillApplicantName()
    solicitude.fillApplicantPhonenumber()
    solicitude.fillText()
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

  it ("form valid if required data, company name and cif are present", () => {
    const solicitude = new Solicitude()
    const solicitudeCompanyValidCif = "A01316637"

    solicitude.fill()
    solicitude.fillCompanyName()
    solicitude.lostFocus()
    expect(solicitude.isSubmitEnabled()).to.eq(false)

    solicitude.fillCompanyCif(solicitudeCompanyValidCif)
    solicitude.lostFocus()
    expect(solicitude.isSubmitEnabled()).to.eq(true)

    expect(solicitude.isCompanyIdentityInfoHidden()).to.eq(true)
  })

  it ("form invalid when company name is present and cif is not", () => {
    const solicitude = new Solicitude()

    solicitude.fillCompanyName()
    solicitude.lostFocus()

    expect(solicitude.isSubmitEnabled()).to.eq(false)
    expect(solicitude.isCompanyIdentityInfoHidden()).to.eq(false)
  })

  it ("form invalid when cif is present and company name is not", () => {
    const solicitude = new Solicitude()

    solicitude.fillCompanyCif()
    solicitude.lostFocus()

    expect(solicitude.isSubmitEnabled()).to.eq(false)
    expect(solicitude.isCompanyIdentityInfoHidden()).to.eq(false)
  })

})
