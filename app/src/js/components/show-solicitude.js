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
      console.log(payload);
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
