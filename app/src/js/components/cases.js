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
  }

  load(){

  }

  watchActions(){

  }

  initializeViews(){
    let listView = {
      'asesora-cases': CasesView
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

  model(){
    return {
      labels: {
        "proposals": "xxxxx",
        "analysis": "xxxxxx",
        "edit": "xxxxx",
        "createCase": "XXXXXX",
        "casesData": "xxxxx"
      },
      values: {
        "proposals": "",
        "analysis": "",
        "casesData": "",
        "id": ""
      },
      translate:function(key,value) {
        this.labels[key] = value
      }
    }
  }
}
