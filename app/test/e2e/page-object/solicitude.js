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

  focusPhone(){
    let phone = $('#phonenumber')
    this.lostFocus()
  }

  focusEmail(){
    let phone = $('#email')
    this.lostFocus()
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

  fillCompanyName(value){
    value = value || "a Company Name"
    let name = $("#company-name")
    name.addValue(value)
  }

  fillCompanyCif(value){
    value = value || "xyz"
    let cif = $("#company-cif")
    cif.addValue(value)
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

  isContactInfoHiden(){
    let contactInfo = $("#contact-info")
    let isHiden = contactInfo.getAttribute("class")
    return isHiden == "hide"
  }

  isContactInfoNotHiden(){
    let contactInfo = $("#contact-info")
    let isHiden = contactInfo.getAttribute("class")
    return isHiden == "hide"
  }

  isCompanyIdentityInfoHidden(){
    return !browser.isVisible('#company-identity-info')
  }

  submit(){
    this.lostFocus()
    $('#submit').click()
    browser.waitUntil(function(){
      return browser.isVisible('.message-sent')}
      , 2000, 'expected text to be different after 2s')
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

  withCompanyName(text){
    this.fillCompanyName(text)
    return this
  }

  withCompanyCif(text){
    this.fillCompanyCif(text)
    return this
  }
  fillCNAE(value){
    let cnae =  $('#company-cnae')
    cnae.setValue(value)
  }

  includesCNAEID(id){
    let cnae =  $('#company-cnae')
    let input = cnae.getValue()
    return input.includes(id)
  }
  cnaeIsEmpty(id){
    let cnae =  $('#company-cnae')
    let input = cnae.getValue()
    return "" == input.includes(id)
  }

}
module.exports = Solicitude
