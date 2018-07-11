import {Bus} from '../bus'
import Component from '../infrastructure/component'
import AsesoraNavbar from '../views/asesora-navbar'

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
        "name": "XXXXXXX",
        "createSolicitude": "XXXXXXXXXX",
        "solicitudeList": "xXxXxXxX"
      },

    translate:function(key,value) {
        this.labels[key] = value
        console.log(this.labels);
      }
    }
  }
}
