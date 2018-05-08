const expect = require('chai').expect
const assert = require('chai').assert
const Solicitude = require('./page-object/solicitude')

describe('Solicitude', () => {

  it ("can be created", () => {
    const solicitude = new Solicitude()

    solicitude.fill().applicantName()
                     .applicantPhonenumber()
                     .description()
    solicitude.lostFocus()

    expect(solicitude.isSubmitEnabled()).to.eq(true)
  })

  it ("hides date info when is not needed", () => {
    const solicitude = new Solicitude()

    solicitude.fill().date()
    solicitude.lostFocus()

    expect(solicitude.isDateInfoHiden()).to.eq(true)
  })

  it ("knows when the date is invalid", () => {
    const solicitude = new Solicitude()
    solicitude.fill().date()
    assert(solicitude.isDateInfoHiden(), true)
    solicitude.lostFocus()

    solicitude.fill().wrongDate()
    solicitude.lostFocus()

    expect(solicitude.isDateInfoHiden()).to.eq(false)
  })

  it ("can be created with phone number and email", () => {
    const solicitude = new Solicitude()

    solicitude.fill().applicantPhonenumber()
                     .applicantEmail()
                     .description()

    solicitude.lostFocus()

    expect(solicitude.isSubmitEnabled()).to.eq(true)
  })

  it ("hides contact info when is not needed", () => {
    const solicitude = new Solicitude()

    solicitude.focusPhone()
              .focusEmail()

    expect(solicitude.isContactInfoHiden()).to.eq(true)
  })

  it ("not hides contact info when is not needed", () => {
    const solicitude = new Solicitude()

    solicitude.fill().applicantEmail()
    solicitude.lostFocus()

    expect(solicitude.isContactInfoNotHiden()).to.eq(true)
  })

  it ("form valid if required data, company name and cif are present", () => {
    const solicitude = new Solicitude()
    const solicitudeCompanyValidCif = "A01316637"

    solicitude.fill().required()
                     .companyName()
    solicitude.lostFocus()
    expect(solicitude.isSubmitEnabled()).to.eq(false)

    solicitude.fill().companyCif(solicitudeCompanyValidCif)
    solicitude.lostFocus()
    expect(solicitude.isSubmitEnabled()).to.eq(true)

    expect(solicitude.isCompanyIdentityInfoHidden()).to.eq(true)
  })

  it ("form invalid when company name is present and cif is not", () => {
    const solicitude = new Solicitude()

    solicitude.fill().companyName()
    solicitude.lostFocus()

    expect(solicitude.isSubmitEnabled()).to.eq(false)
    expect(solicitude.isCompanyIdentityInfoHidden()).to.eq(false)
  })

  it ("form invalid when cif is present and company name is not", () => {
    const solicitude = new Solicitude()

    solicitude.fill().companyCif()
    solicitude.lostFocus()

    expect(solicitude.isSubmitEnabled()).to.eq(false)
    expect(solicitude.isCompanyIdentityInfoHidden()).to.eq(false)
  })

  it("uses CNAE catalog",()=> {
    const solicitude = new Solicitude()
    const cnaeID = "200"
    solicitude.fill().CNAE(cnaeID)
    solicitude.lostFocus()

    expect(solicitude.includesCNAEID(cnaeID)).to.eq(true)

    const incorrectID = "9-9-9"
    solicitude.fill().CNAE(incorrectID)
    solicitude.lostFocus()

    expect(solicitude.cnaeIsEmpty(incorrectID)).to.eq(true)
  })
})
