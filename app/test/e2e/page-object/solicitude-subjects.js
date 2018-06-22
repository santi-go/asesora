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

  clickOnAddCaseButton(){
      browser.waitForVisible('#add-case-button', 2000)
      const data = $('#add-case-button')
      data.click()
  }

  waitFor(field){
    browser.waitForVisible(field, 2000)
    browser.scroll(field)
  }

  waitForSolicitude(){
    this.waitFor('#solicitude')
  }

  waitForAddCaseButton(){
    this.waitFor('#add-case-button')
  }

  waitForCreateCounseling(){
    this.waitFor('#create-counseling')
  }

  fill(){
    return this
  }

  subjectProposal(value){
    value = value || "subject proposal"
    let subjectProposal =  $('#cases-proposals')
    subjectProposal.setValue(value)
    return this
  }

  lostFocus(){
    let keyTab="\u0009"
    browser.keys(keyTab)
  }

  includeSubjectProposal(){
    browser.waitForVisible('.listed-subjects', 2000)
    if(browser.isVisible('.listed-subjects table tr td p')) return true
    return false
  }


}

module.exports = SolicitudeSubjects
