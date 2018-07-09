import Component from '../infrastructure/component'
import {Bus} from '../bus'
import {APIClient} from '../infrastructure/api_client'
import ShowSolicitudeView from '../views/solicitude/asesora-show-solicitude'

export default class ShowSolicitude extends Component {

  constructor(){
    super('show-solicitude')
    this.client = APIClient
    this.load()
  }

  subscribe(){
    Bus.subscribe("got.translation.for.show-solicitude", this.translate.bind(this))
    Bus.subscribe("got.solicitude", this.updateModel.bind(this))
  }

  load(){
    let url = document.URL
    let index = url.indexOf("=")
    let id = url.slice(index + 1)
    if (url.includes("subjects.html")) {
      this.buttonsPresent = false
    }
    Bus.publish('get.solicitude', {id: id})
  }

  watchActions(){
    document.getElementById(this.element).addEventListener(
      'load.solicitude',
      this.loadSolicitudeToEdit.bind(this)
    )

    document.getElementById(this.element).addEventListener(
      'clicked.add.subject',
      this.addSubject.bind(this)
    )
  }

  loadSolicitudeToEdit(event){
    window.location.href = "/index.html?id=" + event.detail
  }

  addSubject(event){
    window.location.href = "/subjects.html?id=" + event.detail
  }

  initializeViews(){
    let listView = {
      'asesora-show-solicitude': ShowSolicitudeView
    }
    super.initializeViews(listView)
  }

  updateModel(payload){
    this.data.values.id = payload.data.creation_moment

    let dictionary = this.dictionaryOfSolicitude(payload)
     for (let [labelKey, valueKey] of Object.entries(dictionary)) {
       this.data.setValues(labelKey, valueKey)
     }
  }

  dictionaryOfSolicitude(payload){
    return {
        'text': payload.data.text,
        'date': payload.data.date,
        'applicantName': payload.data.applicant_name,
        'applicantSurname': payload.data.applicant_surname,
        'applicantCcaa': payload.data.applicant_ccaa,
        'applicantEmail': payload.data.applicant_email,
        'applicantPhonenumber': payload.data.applicant_phonenumber,
        'companyName': payload.data.company_name,
        'companyCif': payload.data.company_cif,
        'companyEmployees': payload.data.company_employees,
        'companyCnae': payload.data.company_cnae,
        'subjects': payload.data.subjects
        }
    }

  translate(payload) {
    let key = payload.key
    let label = payload.label
    this.data.translate(key,label)
  }

  askTranslations() {
    let labelKeys = Object.keys(this.model().labels)
    for (const labelKey of labelKeys) {
      let data = {  for: this.element,
        key: labelKey }
        Bus.publish('ask.translation', data)
      }
    }

  model(){
    return {
      labels: {
        "proposals": "xxxxx",
        "analysis": "xxxxxx",
        "topics": "xxxxxxx",
        "edit": "xxxxx",
        "addSubject": "XXXXXX",
        "subjectsData": "xxxxx",
        "summary": "XxXxXxX",
        "applicant": "xxxxx",
        "company": "xxxxx",
        "applicantName": "XXXX",
        "applicantSurname": "XXXXXXXXX",
        "applicantCcaa": "xxxxx",
        "applicantEmail": "XXX",
        "applicantPhonenumber": "XXXXXXXXX",
        "date": "XXXXX",
        "text": "XXXXX",
        "companyName": "XXXXXXXX",
        "companyCif": "XXXXXX",
        "companyEmployees": "XXXXXX",
        "companyCnae": "XXXXXXXX",
        "subjectsList": "xxxxxxx",
        "notApply": "xxxx",
        "subject": "xxxx"
      },
      values: {
        "id": "",
        "applicantName": "",
        "applicantSurname": "",
        "applicantCcaa": "",
        "applicantEmail": "",
        "applicantPhonenumber": "",
        "date": "",
        "text": "",
        "companyName": "",
        "companyCif": "",
        "companyEmployees": "",
        "companyCnae": "",
        "subjects": ""
      },
      buttonsPresent: true,
      hasSubjects: false,
      setValues:function(key, value) {
        this.values[key] = value
      },
      translate:function(key,value) {
        this.labels[key] = value
      }
    }
  }
}
