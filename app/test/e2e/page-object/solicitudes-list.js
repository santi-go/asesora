const APPLICANT_COLUMN = '3'
const DATE_COLUMN = '2'

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
}

module.exports = SolicitudesList
