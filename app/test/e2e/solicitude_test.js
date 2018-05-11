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

  it ("knows when contacting info is correctly entered", () => {
    const solicitude = new Solicitude()
    const wrongText = "x"
    solicitude.fill().applicantPhonenumber(wrongText)
              .applicantEmail(wrongText)
    solicitude.lostFocus()
    assert(solicitude.isContactInfoVisible(), true)

    solicitude.fill().applicantEmail()
    solicitude.lostFocus()
    expect(solicitude.isContactInfoHiden()).to.eq(true)
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

  it("triggers a search for a company match, when the user types 3 chars in the company name input",()=> {
    const firstSolicitude = new Solicitude()
    const firstCompanyName = "Samuel & Santi"
    const firstCIF = "B91735456"
    firstSolicitude.fill().required().companyName(firstCompanyName).companyCif(firstCIF)
    firstSolicitude.submit()

    const secondSolicitude = new Solicitude()
    const secondCompanyName = "Samuel & Mikel"
    const secondCIF = "G98128218"
    const CNAE = "931 - Actividades deportivas"
    secondSolicitude.fill().required().companyName(secondCompanyName).CNAE(CNAE).companyCif(secondCIF)
    secondSolicitude.submit()

    const thirdSolicitude = new Solicitude()
    thirdSolicitude.fill().companyName("Sam")
    let numberOfMatches = thirdSolicitude.numberOfCompanyMatches()

    expect(numberOfMatches).to.be.gt(1)

    const fourthSolicitude = new Solicitude()
    fourthSolicitude.fill().companyName("###@@@@")
    numberOfMatches = fourthSolicitude.numberOfCompanyMatches()

    expect(numberOfMatches).to.eq(0)
  })

  it("narrow the company matches when given a cnae",()=> {
    const firstSolicitude = new Solicitude()
    const firstCompanyName = "Samuel & Santi"
    const firstCIF = "B91735456"
    firstSolicitude.fill().required().companyName(firstCompanyName).companyCif(firstCIF)
    firstSolicitude.submit()

    const secondSolicitude = new Solicitude()
    const secondCompanyName = "Samuel & Mikel"
    const secondCIF = "G98128218"
    const CNAE = "931 - Actividades deportivas"
    secondSolicitude.fill().required().companyName(secondCompanyName).CNAE(CNAE).companyCif(secondCIF)
    secondSolicitude.submit()

    const thirdSolicitude = new Solicitude()
    thirdSolicitude.fill().companyName("Sam")
    let numberOfMatchesInicial = thirdSolicitude.numberOfCompanyMatches()

    thirdSolicitude.fill().CNAE("931").lostFocus()
    thirdSolicitude.fill().companyName("Sam")
    let numberOfMatchesFinal = thirdSolicitude.numberOfCompanyMatches()

    expect(numberOfMatchesInicial).to.be.gt(numberOfMatchesFinal)
  })
})
