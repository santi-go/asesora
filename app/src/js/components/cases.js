import Component from '../infrastructure/component'
import {Bus} from '../bus'
import {APIClient} from '../infrastructure/api_client'
import CasesView from '../views/solicitude/asesora-cases'


export default class Cases extends Component {

  constructor(){
    super('cases')
    this.client = APIClient
    this.load()
  }

  subscribe(){
    Bus.subscribe("got.translation.for.cases", this.translate.bind(this))
    Bus.subscribe("subject.created", this.subjectCreated.bind(this))
    Bus.subscribe("got.topics-catalog", this.gotTopicsCatalog.bind(this))
  }

  load(){
    this.data.values.solicitudeId = this.getSolicitudeId()
  }

  watchActions(){
    document.getElementById(this.element).addEventListener(
      'clicked.create.counseling',
      this.createCounseling.bind(this)
    )
  }

  initializeViews(){
    let listView = {
      'asesora-cases': CasesView,
    }
    super.initializeViews(listView)
  }

  askTranslations() {
    let labelKeys = Object.keys(this.model().labels)
    for (const labelKey of labelKeys) {
      let data = {  for: this.element,
        key: labelKey }
        Bus.publish('ask.translation', data)
      }
    }

  translate(payload) {
    let key = payload.key
    let label = payload.label
    this.data.translate(key,label)
  }

  createCounseling(payload){
    Bus.publish('create.subject', payload.detail)
  }

  subjectCreated(payload) {
    console.log(payload);
    window.location.href = "/index.html?id=" + payload.solicitude_id
  }

  gotTopicsCatalog(payload) {
    this.data.topicsCatalog = payload.data
  }

  getSolicitudeId() {
    let url = document.URL
    let index = url.indexOf("=")
    let id = url.slice(index + 1)

    return id
  }

  model(){
    return {
      labels: {
        "proposals": "xxxxx",
        "analysis": "xxxxxx",
        "edit": "xxxxx",
        "addSubject": "XXXXXX",
        "createSubject": "XxX",
        "casesData": "xxxxx",
        "topics": "Temas del caso"
      },
      values: {
        "solicitudeId": "",
        "proposals": "",
        "analysis": "",
        "subjectId":"",
        "topics": ""
      },
      topicsCatalog: [],
      translate:function(key,value) {
        this.labels[key] = value
      }
    }
  }
}
