const APPLICANT_COLUMN = '3'

class SolicitudesList{

  constructor(){
    browser.url('/solicitudes-list.html')
  }

  existApplicant(name){
    const data = $('#solicitudes-list tbody')
    const applicants = data.$$(`tr td:nth-child(${APPLICANT_COLUMN})`)
    for (let applicant of applicants){
      if(applicant.getText() == name) return true
    }
    return false
  }

  existNotApplicant(notApplicant){
    const data = $('#solicitudes-list tbody')
    const applicants = data.$$(`tr td:nth-child(${APPLICANT_COLUMN})`)
    for (let applicant of applicants){
      if(applicant.getText() == notApplicant) return true
    }
    return false
  }
}

module.exports = SolicitudesList
