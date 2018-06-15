import CasesView from '../views/solicitude/asesora-cases'
import Component from '../infrastructure/component'
import {Bus} from '../bus'
import {APIClient} from '../infrastructure/api_client'

export default class Cases extends Component {

  constructor(){
    super('cases')
    this.client = APIClient
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
        "analysis": "xxxxxx"
      },
      values: {
        "proposals": "",
        "analysis": ""
      },
      translate:function(key,value) {
        this.labels[key] = value
      }
    }
  }
}
