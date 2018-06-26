const expect = require('chai').expect
const assert = require('chai').assert
const SolicitudesList = require('./page-object/solicitudes-list')
const SolicitudeSubjects = require('./page-object/solicitude-subjects')
const Solicitude = require('./page-object/solicitude')
const Fixtures = require('./fixtures')

describe('Solicitude Subjects', () => {
  before(function(){
    fixtures = new Fixtures()
    fixtures.pristine()
  })

  afterEach(function(){
    fixtures = new Fixtures()
    fixtures.clean()
  })

  it("are rendered in a subject list within edition solicitude", function () {
    const newProposal = "A new proposal"
    const newAnalysis = "Other Analysis"
    const solicitudesList = new SolicitudesList()
    solicitudesList.waitForSolicitudesList()
    solicitudesList.clickOnShowButtonOnItem(1)

    const solicitudeSubjects = new SolicitudeSubjects()
    solicitudeSubjects.clickOnAddSubjectButton()
    solicitudeSubjects.fill().subjectAnalysis(newAnalysis).lostFocus()
    solicitudeSubjects.fill().subjectProposal(newProposal).lostFocus()
    solicitudeSubjects.waitForCreateCounseling()
    solicitudeSubjects.clickOnCreateCounseling()
    solicitudeSubjects.waitForSolicitude()

    result = solicitudeSubjects.includeSubjectProposal()
    expect(result).to.eq(true)
  })

  it("enables button when there is an analysis", function () {

    const newAnalysis = "Other Analysis"
    const solicitude = new Solicitude()

    solicitude.required().submit()
    
    const solicitudesList = new SolicitudesList()

    solicitudesList.waitForSolicitudesList()
    browser.saveScreenshot("test.png")
    solicitudesList.clickOnShowButtonOnItem(1)

    const solicitudeSubjects = new SolicitudeSubjects()
    solicitudeSubjects.clickOnAddSubjectButton()
    solicitudeSubjects.fill().subjectAnalysis(newAnalysis).lostFocus()

    result = solicitudeSubjects.isCreateCounselingEnabled()

    expect(result).to.eq(true)
  })
})
