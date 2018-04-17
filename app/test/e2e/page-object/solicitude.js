class Solicitude{

  constructor(){
    browser.url('/')
  }

  fillAplicant(){
    let applicant =  $('#applicant')
    applicant.setValue("applicant name")
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
}
module.exports = Solicitude
