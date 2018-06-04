class Solicitude{

  constructor(){
    browser.url('/')
  }

  acceptAlert(){
    browser.alertAccept()
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

  description(value){
    value = value || "sample text"
    let text = $('#solicitude-text')
    text.addValue(value)
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

  companyEmployees(value){
    value = value || "2"
    let employees = $("#company-employees")
    employees.addValue(value)
    return this
  }

  companyCnae(value){
    value = value || "011"
    let cnae = $("#company-cnae")
    cnae.addValue(value)
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

  isEditCompanyAlertVisible(){
    return browser.isVisible('#alert-edit-company')
  }

  isEditCompanyButtonVisible(){
    return browser.isVisible('#edit-company')
  }

  hasCompanyMatches(){
    return browser.isVisible('#company-matches tbody')
  }

  numberOfCompanyMatches(){
    browser.waitForVisible('#company-matches tbody', 2000)
    const data = $('#company-matches tbody')
    let matches = data.$$(`tr td:nth-child(1)`).length

    return matches
  }

  clickOnCompanyMatches(){
    browser.waitForVisible('#company-matches tbody', 2000)
    const data = $('#company-matches tbody')
    data.click()
  }

  clickOnEditCompany(){
    const data = $('#edit-company')
    data.click()
    return this
  }

  clickOnSaveCompany(){
    const data = $('#save-company')
    data.click()
    return this
  }

  clickOnDiscardCompany(){
    const data = $('#discard-company')
    data.click()
    return this
  }

  submit(){
    this.lostFocus()
    $('#submit').click()
    browser.waitForVisible('.messageSent', 2000)
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

  CNAEIDisValid(id){
    browser.waitForVisible('#company-cnae', 2000)
    let cnae =  $('#company-cnae')
    let input = cnae.getValue()
    return input.includes(id)
  }

  cnaeIsEmpty(id){
    let cnae =  $('#company-cnae')
    let input = cnae.getValue()
    return "" == input.includes(id)
  }

  CNAELongFormat(id){
    let cnae =  $('#company-cnae')
    let input = cnae.getValue()
    return input
  }

  includesCompanyCif(cif){
    let company_cif =  $('#company-cif')
    let input = company_cif.getValue()
    return input.includes(cif)
  }

  wait(){
    browser.waitForVisible('#name', 2000)
  }

  applicantNameValue(){
     return $('#name').getValue()
  }

  applicantSurnameValue(){
     return $('#surname').getValue()
  }

  applicantEmailValue(){
     return $('#email').getValue()
  }

  applicantPhonenumberValue(){
     return $('#phonenumber').getValue()
  }

  companyNameValue(){
     return $('#company-name').getValue()
  }

  companyCifValue(){
     return $('#company-cif').getValue()
  }

  companyEmployeesValue(){
     return $('#company-employees').getValue()
  }

  companyCnaeValue(){
     return $('#company-cnae').getValue()
  }

  dateValue(){
     return $('#date').getValue()
  }

  textValue(){
    return $('#solicitude-text').getValue()
  }

}
module.exports = Solicitude
