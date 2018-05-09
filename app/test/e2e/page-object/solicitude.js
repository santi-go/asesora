class Solicitude{

  constructor(){
    browser.url('/')
  }

  fill(){
    return this
  }

  applicantName(value){
    value = value || "applicant name"
    let applicantName =  $('#name')
    applicantName.setValue(value)
    return this
  }

  applicantSurname(value){
    value = value || "applicant surname"
    let applicantSurname =  $('#surname')
    applicantSurname.setValue(value)
    return this
  }

  applicantPhonenumber(value){
    value = value || "666666666"
    let phonenumber =  $('#phonenumber')
    phonenumber.setValue(value)
    return this
  }

  applicantEmail(value){
    value = value || "a@a.com"
    let applicantEmail =  $('#email')
    applicantEmail.setValue(value)
    return this
  }

  description(){
    let text =  $('#solicitude-text')
    text.setValue("sample text")
    return this
  }

  date(value){
    value = value || "01/01/2018"
    let date = $("#date")
    date.addValue(value)
    return this
  }

  wrongDate(){
    let date = $("#date")
    date.addValue("02/31/2018")
    return this
  }

  companyName(value){
    value = value || "a Company Name"
    let name = $("#company-name")
    name.addValue(value)
    return this
  }

  companyCif(value){
    value = value || "xyz"
    let cif = $("#company-cif")
    cif.addValue(value)
    return this
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
    return !browser.isVisible("#date-info")
  }

  isContactInfoHiden(){
    return !this.isContactInfoVisible()
  }

  isContactInfoVisible(){
    return browser.isVisible("#contact-info")
  }

  isCompanyIdentityInfoHidden(){
    return !browser.isVisible('#company-identity-info')
  }

  submit(){
    this.lostFocus()
    $('#submit').click()
    browser.waitUntil(function(){
      return browser.isVisible('.messageSent')}
      , 2000, 'expected text to be different after 2s')
  }

  required(){
    this.applicantPhonenumber()
    this.description()
    return this
  }

  CNAE(value){
    let cnae =  $('#company-cnae')
    cnae.setValue(value)
    return this
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
