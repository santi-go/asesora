import AsesoraNavbar from '../views/asesora-navbar'
import Component from '../infrastructure/component'
import {Bus} from '../bus'

export default class Navbar extends Component{

  constructor(){
    super('navbar')
  }

  subscribe(){
    Bus.subscribe("got.translation.for.navbar", this.translate.bind(this))
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
    let listView =  {
        'asesora-navbar': AsesoraNavbar
      }
    super.initializeViews(listView)

  }

  model(){
    return {
      labels: {
        "name": "xxxxxxxxxxxxx",
        "createSolicitude": "xxxxxxxxxxxxx",
        "solicitudeList": "xxxxxxxxxxxxx"
      },

      translate:function(key,value) {
        this.labels[key] = value
      }
    }
  }
}
