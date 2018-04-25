class Solicitude{

  constructor(){
    browser.url('/')
  }

  fillApplicantName(value){
    value = value || "applicant name"
    let applicantName =  $('#name')
    applicantName.setValue(value)
  }

  fillApplicantSurname(value){
    value = value || "applicant surname"
    let applicantSurname =  $('#surname')
    applicantSurname.setValue(value)
  }

  fillApplicantPhonenumber(value){
    value = value || "666666666"
    let applicantPhonenumber =  $('#phonenumber')
    applicantPhonenumber.setValue(value)
  }

  fillApplicantEmail(value){
    value = value || "a@a.com"
    let applicantEmail =  $('#email')
    applicantEmail.setValue(value)
  }

  fillText(){
    let text =  $('#solicitude-text')
    text.setValue("sample text")
  }

  fillDate(value){
    value = value || "01/01/2018"
    let date = $("#date")
    date.addValue(value)
  }

  fillWrongDate(){
    let date = $("#date")
    date.addValue("02/31/2018")
  }

  lostFocus(){
    let keyTab="\u0009"
    browser.keys(keyTab)
  }

  isSubmitEnabled(){
    let submit =  $('#submit')
    let isDisabled = submit.getAttribute("disabled")

    return isDisabled == null
  }

  isDateInfoHiden(){
    let dateInfo = $("#date-info")
    let isHiden = dateInfo.getAttribute("class")
    return isHiden == "hide"
  }

  submit(){
    this.lostFocus()
    $('#submit').click()
    browser.waitForVisible('.message-sent', 2000)
  }

  fill(){
    this.fillApplicantPhonenumber()
    this.fillText()
    return this
  }

  withApplicantName(text){
    this.fillApplicantName(text)
    return this
  }

  withApplicantSurname(text){
    this.fillApplicantSurname(text)
    return this
  }
}
module.exports = Solicitude
