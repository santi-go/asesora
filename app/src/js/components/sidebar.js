import {Bus} from '../bus'
import Component from '../infrastructure/component'
import AsesoraSidebar from '../views/asesora-sidebar'
export default class Sidebar extends Component {

  constructor(){
    super('sidebar')
  }

  subscribe(){
    Bus.subscribe("got.translation.for.sidebar", this.translate.bind(this))
  }

  translate(payload) {
    let key= payload.key
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

  initializeViews(){
    let listView = {
      'asesora-sidebar': AsesoraSidebar
    }
    super.initializeViews(listView)
  }

  model(){
    return {
      labels: {
        "createSolicitude": "",
        "solicitudeList": ""
      },

      translate:function(key,value) {
        this.labels[key] = value
      }
    }
  }
}
