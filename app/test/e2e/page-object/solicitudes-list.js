const Solicitude = require('./solicitude')

const APPLICANT_COLUMN = '3'
const DATE_COLUMN = '2'
const COMPANY_NAME_COLUMN = '4'

class SolicitudesList {

  constructor(){
    browser.url('/solicitudes-list.html')
  }

  existApplicant(name){
    browser.waitForVisible('#solicitudes-list', 2000)
    const data = $('#solicitudes-list tbody')
    const applicants = data.$$(`tr td:nth-child(${APPLICANT_COLUMN})`)
    for (let applicant of applicants){
      if(applicant.getText() == name) return true
    }
    return false
  }

  existCompanyName(name){
    browser.waitForVisible('#solicitudes-list', 2000)
    const data = $('#solicitudes-list tbody')
    const companies = data.$$(`tr td:nth-child(${COMPANY_NAME_COLUMN})`)
    for (let company of companies){
      if(company.getText() == name) return true
    }
    return false
  }

  existNotApplicant(solicitudeDate, notApplicant){
    const data = $('#solicitudes-list tbody')
    const applicantNames =  data.$$(`tr td:nth-child(${APPLICANT_COLUMN})`)
    const solicitudeDates = data.$$(`tr td:nth-child(${DATE_COLUMN})`)

    for ( let counter = 0; counter < applicantNames.length; counter++){
      let name = applicantNames[counter].getText() == notApplicant
      let date = solicitudeDates[counter].getText() == solicitudeDate
      if (name && date) return true
    }
    return false
  }

  withoutCompany(solicitudeDate, notApply){
    const data = $('#solicitudes-list tbody')
    const companyNames =  data.$$(`tr td:nth-child(${COMPANY_NAME_COLUMN})`)
    const solicitudeDates = data.$$(`tr td:nth-child(${DATE_COLUMN})`)

    for ( let counter = 0; counter < companyNames.length; counter++){
      let name = companyNames[counter].getText() == notApply
      let date = solicitudeDates[counter].getText() == solicitudeDate

      if (name && date) return true
    }
    return false
  }

  numberOfSolicitudes(){
    browser.waitForVisible('#solicitudes-list', 2000)
    const data = $('#solicitudes-list tbody')
    const companyNames =  data.$$(`tr td:nth-child(${COMPANY_NAME_COLUMN})`)

    return companyNames.length
  }

  clickOnEditButtonOnItem(item){
      browser.waitForVisible('#solicitudes-list', 2000)
      const data = $(`.solicitude-edit-button:nth-child(${item})` )
      data.click()

      const visitURL = false
      return new Solicitude(visitURL)
  }

  clickOnShowButtonOnItem(item){
      browser.waitForVisible('#solicitudes-list', 2000)
      const data = $(`.solicitude-show-button:nth-child(${item})` )
      data.click()
  }

  isSolicitudesListVisible(){
    return browser.isVisible('#solicitudes-list')
  }

  waitFor(field){
    browser.waitForVisible(field, 2000)
    browser.scroll(field)
  }

  waitForSolicitudesList(){
    this.waitFor('#solicitudes-list')
  }

}

module.exports = SolicitudesList
