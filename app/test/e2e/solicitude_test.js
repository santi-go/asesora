const expect = require('chai').expect
const assert = require('chai').assert
const Solicitude = require('./page-object/solicitude')
const Fixtures = require('./fixtures')


describe('Solicitude', () => {
  beforeEach(function(){
    fixtures = new Fixtures()
    fixtures.clean()
  })

  it("didn't have delete button", function () {
    const solicitude = new Solicitude()
    solicitude.fill()
      .applicantPhonenumber()
      .description()
    solicitude.lostFocus()

    expect(solicitude.isDeleteSolicitudeButtonVisible()).to.eq(false)
  })

  describe("can be created",() => {
    it("with phone and description", () => {
      const solicitude = new Solicitude()
      solicitude.acceptAlert()
      solicitude.fill()
        .applicantPhonenumber()
        .description()
      solicitude.lostFocus()

      expect(solicitude.isSubmitEnabled()).to.eq(true)
    })

    it("with email and description", () => {
      const solicitude = new Solicitude()
      solicitude.acceptAlert()
      solicitude.fill()
        .applicantEmail()
        .description()
      solicitude.lostFocus()

      expect(solicitude.isSubmitEnabled()).to.eq(true)
    })
  })

  it("can not be created without phone or email", () => {
    const solicitude = new Solicitude()
    solicitude.acceptAlert()
    solicitude.fill()
              .description()
    solicitude.lostFocus()

    expect(solicitude.isSubmitEnabled()).to.eq(false)
  })

  it("can not be created without description", () => {
    const solicitude = new Solicitude()
    solicitude.acceptAlert()
    solicitude.fill()
              .applicantEmail()
    solicitude.lostFocus()

    expect(solicitude.isSubmitEnabled()).to.eq(false)
  })

  it("hides date info when is not needed", () => {
    const solicitude = new Solicitude()
    solicitude.acceptAlert()
    solicitude.fill().date()
    solicitude.lostFocus()

    expect(solicitude.isDateInfoHiden()).to.eq(true)
  })

  it("knows when the date is invalid", () => {
    const solicitude = new Solicitude()
    solicitude.acceptAlert()
    solicitude.fill().date()
    assert(solicitude.isDateInfoHiden(), true)
    solicitude.lostFocus()

    solicitude.fill().wrongDate()
    solicitude.lostFocus()

    expect(solicitude.isDateInfoHiden()).to.eq(false)
  })

  it("can be created with phone number and email", () => {
    const solicitude = new Solicitude()
    solicitude.fill().applicantPhonenumber()
                     .applicantEmail()
                     .description()

    solicitude.lostFocus()
    expect(solicitude.isSubmitEnabled()).to.eq(true)
  })

  it("knows when contacting info is correctly entered", () => {
    const solicitude = new Solicitude()
    solicitude.acceptAlert()
    const wrongText = "x"
    solicitude.fill().applicantPhonenumber(wrongText)
    .applicantEmail(wrongText)
    solicitude.lostFocus()
    assert(solicitude.isContactInfoVisible(), true)

    solicitude.fill().applicantEmail()
    solicitude.lostFocus()
    expect(solicitude.isContactInfoHiden()).to.eq(true)
  })

  it("form valid if required data, company name and cif are present", () => {
    const solicitude = new Solicitude()
    solicitude.acceptAlert()
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

  it("form invalid when company name is present and cif is not", () => {
    const solicitude = new Solicitude()
    solicitude.acceptAlert()

    solicitude.fill().companyName()
    solicitude.lostFocus()

    expect(solicitude.isSubmitEnabled()).to.eq(false)
    expect(solicitude.isCompanyIdentityInfoHidden()).to.eq(false)
  })

  it ("form invalid when cif is present and company name is not", () => {
    const solicitude = new Solicitude()
    solicitude.acceptAlert()

    solicitude.fill().companyCif()
    solicitude.lostFocus()

    expect(solicitude.isSubmitEnabled()).to.eq(false)
    expect(solicitude.isCompanyIdentityInfoHidden()).to.eq(false)
  })

  it ("uses CNAE catalog",()=> {
    const solicitude = new Solicitude()
    solicitude.acceptAlert()
    const cnaeID = "200"
    solicitude.fill().CNAE(cnaeID)
    solicitude.lostFocus()

    assert(solicitude.CNAEIDisValid(cnaeID), true)

    let CNAELongFormat = solicitude.CNAELongFormat(cnaeID)
    let addedCorrectly = cnaeID.length < CNAELongFormat.length
    expect(addedCorrectly).to.eq(true)
  })

  it ("triggers a search for a company match, when the user types 3 chars in the company name input",()=> {
    const nameToMatch = "Sam"
    const solicitudeToKnowMatches = new Solicitude()
    solicitudeToKnowMatches.acceptAlert()
    solicitudeToKnowMatches.fill().companyName(nameToMatch)
    expect(solicitudeToKnowMatches.hasCompanyMatches()).to.be.false

    const firstSolicitude = new Solicitude()
    firstSolicitude.acceptAlert()
    const firstCompanyName = "Samuel & Santi"
    const firstCIF = "N2902211H"
    firstSolicitude.fill().required().companyName(firstCompanyName).companyCif(firstCIF)
    firstSolicitude.submit()

    const secondSolicitude = new Solicitude()
    const secondCompanyName = "Samuel & Mikel"
    const secondCIF = "F0956154I"
    const CNAE = "931 - Actividades deportivas"
    secondSolicitude.fill().required().companyName(secondCompanyName).CNAE(CNAE).companyCif(secondCIF)
    secondSolicitude.submit()

    const thirdSolicitude = new Solicitude()
    thirdSolicitude.fill().companyName(nameToMatch)
    let numberOfMatches = thirdSolicitude.numberOfCompanyMatches()

    expect(thirdSolicitude.numberOfCompanyMatches()).to.eq(2)
  })

  it ("company allows filled with matches", () => {
    const solicitude = new Solicitude()
    solicitude.acceptAlert()
    let name = 'Devscola'
    let cif = 'G53910758'
    solicitude.fill().required()
    .companyName(name)
    .companyCif(cif)
    .submit()

    const second_solicitude = new Solicitude()
    second_solicitude.companyName(name)
    second_solicitude.clickOnCompanyMatches()
    expect(second_solicitude.includesCompanyCif(cif)).to.eq(true)
  })

  it ("narrow the company matches when given a cnae",()=> {
    const firstSolicitude = new Solicitude()
    firstSolicitude.acceptAlert()
    const firstCompanyName = "Samuel & Santi"
    const firstCIF = "F8819575E"
    firstSolicitude.fill().required().companyName(firstCompanyName).companyCif(firstCIF)
    firstSolicitude.submit()

    const secondSolicitude = new Solicitude()
    const secondCompanyName = "Samuel & Mikel"
    const secondCIF = "R1568912H"
    const CNAE = "931 - Actividades deportivas"
    secondSolicitude.fill().required().companyName(secondCompanyName).CNAE(CNAE).companyCif(secondCIF)
    secondSolicitude.submit()

    const thirdSolicitude = new Solicitude()
    thirdSolicitude.fill().companyName("Sam").lostFocus()
    expect(thirdSolicitude.numberOfCompanyMatches()).to.eq(2)

    thirdSolicitude.fill().CNAE("931").lostFocus()
    expect(thirdSolicitude.numberOfCompanyMatches()).to.eq(1)
  })


})
