class Solicitude{

  constructor(){
    browser.url('/')
  }

  fillAplicant(value){
    value = value || "applicant name"
    let applicant =  $('#applicant')
    applicant.setValue(value)
  }

  fillText(){
    let text =  $('#solicitude-text')
    text.setValue("sample text")
  }

  fillDate(){
    let date = $("#date")
    date.addValue("01/01/2018")
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
    this.fillAplicant()
    this.fillText()
    return this
  }

  withApplicant(text){
    this.fillAplicant(text)
    return this
  }
}
module.exports = Solicitude
