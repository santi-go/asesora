const SOLICITUDE_URL = '/index.html'

class Solicitude {

  constructor(visitURL = true){
    if (visitURL) {
      browser.url(SOLICITUDE_URL)
    }
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
    date.addValue("01/mm/aaaa")
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
    let cnae = $("#company-cnae input")
    cnae.selectByValue(value);
    return this
  }

  lostFocus(){
    let keyTab="\u0009"
    browser.keys(keyTab)
  }

  selectedFirstOption(){
      let selected = $('#company-cnae .current')
      selected.click()
  }

  timeout(time){
    browser.timeouts('script', time);
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

  isAddEmployeesValueButtonVisible(){
    return browser.isVisible('#add-employees-value')
  }

  isAddNameValueButtonVisible(){
    return browser.isVisible('#add-name-value')
  }

  isAddedEmployeesValueVisible(){
    return browser.isVisible('#added-employees-value-message')
  }

  isAddedNameValueVisible(){
    return browser.isVisible('#added-name-value-message')
  }

  isDeleteSolicitudeButtonVisible(){
    return browser.isVisible('#delete-solicitude')
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

  clickOnDeleteSolicitude(){
    const data = $('#delete-solicitude')
    data.click()
    return this
  }

  clickOnEditCompany(){
    const data = $('#edit-company')
    data.click()
    return this
  }

  clickOnAddEmployeesValueButton(){
    const data = $('#add-employees-value')
    data.click()
    return this
  }

  clickOnAddNameValueButton(){
    const data = $('#add-name-value')
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

  clickOnDiscardButton(){
    const data = $('#discard')
    data.click()
    return this
  }

  submit(){
    this.lostFocus()
    $('#submit').click()
    browser.waitForVisible('.messageSent', 5000)
  }

  submitAndAddSubject(){
    this.lostFocus()
    $('#submit-and-add-subject').click()
    browser.waitForVisible('.messageSent', 5000)
  }

  required(){
    this.applicantPhonenumber()
    this.description()
    return this
  }

  CNAE(value){
    let cnae =  $('#company-cnae input')
    cnae.setValue(value)
    return this
  }

  CNAEIDisValid(id){
    browser.waitForVisible('#company-cnae .text', 2000)
    let input = this.companyCnaeValue()
    return input.includes(id)
  }

  cnaeIsEmpty(id){
    let input = this.companyCnaeValue()
    return "" == input.includes(id)
  }

  CNAELongFormat(){
    let input = this.companyCnaeValue()
    return input
  }

  includesCompanyCif(cif){
    let company_cif =  $('#company-cif')
    let input = company_cif.getValue()
    return input.includes(cif)
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
     return $('#company-cnae .text').getText()
  }

  dateValue(){
     return $('#date').getValue()
  }

  textValue(){
    return $('#solicitude-text').getValue()
  }

  waitFor(field){
    browser.waitForVisible(field, 2000)
    browser.scroll(field)
  }

  waitForSubmitAndAddSubject(){
    this.waitFor('#submit-and-add-subject')
  }

  waitForSolicitude(){
    this.waitFor('#solicitude')
  }

  waitForPhonenumber(){
    this.waitFor('#phonenumber')
  }

  waitForAlertEditCompany(){
    this.waitFor('#alert-edit-company')
  }

  waitForCompanyName(){
    this.waitFor('#company-name')
  }

  waitForAddNameValue(){
    this.waitFor('#add-name-value')
  }

}
module.exports = Solicitude
