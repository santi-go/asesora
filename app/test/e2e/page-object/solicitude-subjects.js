class SolicitudeSubjects{

  constructor(){
  }

  acceptAlert(){
    browser.alertAccept()
  }

  clickOnEditButton(){
      browser.waitForVisible('#edit-button', 2000)
      const data = $('#edit-button')
      data.click()
  }

  clickOnCreateCounseling(){
      browser.waitForVisible('#create-counseling', 2000)
      const data = $('#create-counseling')
      data.click()
  }

  clickOnAddSubjectButton(){
      browser.waitForVisible('#add-subject-button', 2000)
      const data = $('#add-subject-button')
      data.click()
  }

  waitFor(field){
    browser.waitForVisible(field, 2000)
    browser.scroll(field)
  }

  waitForSolicitude(){
    this.waitFor('#solicitude')
  }

  waitForSubjectsList(){
    this.waitFor('#subjects-list')
  }

  waitForAddSubjectButton(){
    this.waitFor('#add-subject-button')
  }

  waitForSubjectProposal(){
        this.waitFor('#subject-proposals')
  }

  waitForCreateCounseling(){
    this.waitFor('#create-counseling')
  }

  fill(){
    return this
  }

  subjectProposal(value){
    value = value || "subject proposal"
    let subjectProposal =  $('#subject-proposals')
    subjectProposal.setValue(value)
    return this
  }

  subjectAnalysis(value){
    value = value || "subject analysis"
    let subjectProposal =  $('#analysis-solicitude')
    subjectProposal.setValue(value)
    return this
  }

  lostFocus(){
    let keyTab="\u0009"
    browser.keys(keyTab)
  }

  isCreateCounselingButtonVisible(){
    return browser.isVisible('#create-counseling')
  }

  isSubjectsVisible(){
    return browser.isVisible('#subjects')
  }

  isCreateCounselingEnabled(){
    let submit =  $('#create-counseling')
    let isDisabled = submit.getAttribute("disabled")

    return isDisabled == null
  }

  includeSubjectList(){
    browser.waitForVisible('#subjects-list', 2000)
    if(browser.isVisible('#subjects-list')) return true
    return false
  }


}

module.exports = SolicitudeSubjects
