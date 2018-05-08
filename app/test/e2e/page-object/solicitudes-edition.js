class SolicitudesEdition{

  constructor(){
    browser.url('/solicitudes-edition.html')
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

  description(){
    let text =  $('#solicitude-text')
    text.setValue("sample text")
    return this
  }

  date(){
    let date = $("#date")
    date.addValue("01/01/2018")
    return this
  }

  wrongDate(){
    let date = $("#date")
    date.addValue("02/31/2018")
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
}
module.exports = SolicitudesEdition
