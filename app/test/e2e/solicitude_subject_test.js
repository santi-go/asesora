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

  after(function(){
    fixtures = new Fixtures()
    fixtures.clean()
  })

  it("are rendered in a subject list within show solicitude", function () {
    const newAnalysis = "Other Analysis"
    const solicitudesList = new SolicitudesList()
    solicitudesList.waitForSolicitudesList()
    solicitudesList.clickOnShowButtonOnItem(1)

    const solicitudeSubjects = new SolicitudeSubjects()
    solicitudeSubjects.clickOnAddSubjectButton()
    solicitudeSubjects.fill().subjectAnalysis(newAnalysis).lostFocus()
    solicitudeSubjects.waitForCreateCounseling()
    solicitudeSubjects.clickOnCreateCounseling()
    solicitudeSubjects.waitForSubjectsList()

    result = solicitudeSubjects.includeSubjectProposal()
    expect(result).to.eq(true)
  })

  it("enables button when there is an analysis", function () {

    const newAnalysis = "Other Analysis"
    const solicitude = new Solicitude()

    solicitude.required().submit()

    const solicitudesList = new SolicitudesList()

    solicitudesList.waitForSolicitudesList()
    solicitudesList.clickOnShowButtonOnItem(1)

    const solicitudeSubjects = new SolicitudeSubjects()
    solicitudeSubjects.clickOnAddSubjectButton()
    solicitudeSubjects.fill().subjectAnalysis(newAnalysis).lostFocus()

    result = solicitudeSubjects.isCreateCounselingEnabled()

    expect(result).to.eq(true)
  })

  it("would show add subject after create solicitude", function () {
    const solicitude = new Solicitude()

    solicitude.required().submitAndAddSubject()

    const solicitudeSubjects = new SolicitudeSubjects()
    solicitudeSubjects.waitFor('#show-solicitude')

    expect(solicitudeSubjects.isSubjectsVisible()).to.eq(true)
  })

  it("would show add subject after modify solicitude", function () {
    const solicitude = new Solicitude()

    solicitude.required().submit()

    const solicitudesList = new SolicitudesList()
    solicitudesList.waitForSolicitudesList()
    solicitudesList.clickOnEditButtonOnItem(1)

    solicitude.fill().applicantName()
    solicitude.submitAndAddSubject()

    const solicitudeSubjects = new SolicitudeSubjects()
    solicitudeSubjects.waitFor('#show-solicitude')

    expect(solicitudeSubjects.isSubjectsVisible()).to.eq(true)
  })
})
