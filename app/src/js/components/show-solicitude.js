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
    Bus.subscribe("got.solicitude", this.populateStaticSolicitude.bind(this))
  }

  load(){
    let url = document.URL
    let index = url.indexOf("=")
    let id = url.slice(index + 1)
    Bus.publish('get.solicitude', {id: id})
    }

  watchActions(){
  }

  initializeViews(){
    let listView = {
      'asesora-show-solicitude': ShowSolicitudeView
    }
    super.initializeViews(listView)
  }

  populateStaticSolicitude(payload){
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
        'applicantEmail': payload.data.applicant_email,
        'applicantPhonenumber': payload.data.applicant_phonenumber,
        'companyName': payload.data.company_name,
        'companyCif': payload.data.company_cif,
        'companyEmployees': payload.data.company_employees,
        'companyCnae': payload.data.company_cnae
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
        "casesData": "xxxxx",
        "applicant": "xxxxx",
        "company": "xxxxx",
        "applicantName": "XXXX",
        "applicantSurname": "XXXXXXXXX",
        "applicantEmail": "XXX",
        "applicantPhonenumber": "XXXXXXXXX",
        "date": "XXXXX",
        "text": "XXXXX",
        "companyName": "XXXXXXXX",
        "companyCif": "XXXXXX",
        "companyEmployees": "XXXXXX",
        "companyCnae": "XXXXXXXX"
      },
      values: {
        "proposals": "",
        "analysis": "",
        "casesData": "",
        "applicantName": "",
        "applicantSurname": "",
        "applicantEmail": "",
        "applicantPhonenumber": "",
        "date": "",
        "text": "",
        "companyName": "",
        "companyCif": "",
        "companyEmployees": "",
        "companyCnae": ""
      },
      setValues:function(key, value) {
        this.values[key] = value
      },
      translate:function(key,value) {
        this.labels[key] = value
      }
    }
  }
}
