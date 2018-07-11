import AsesoraNavbar from '../views/asesora-navbar'
import Component from '../infrastructure/component'
import {Bus} from '../bus'

export default class Navbar extends Component{

  constructor(){
    super('navbar')
    this.retrieve()
  }

  subscribe(){
    Bus.subscribe("got.information", this.setInfo.bind(this))
    Bus.subscribe("got.information", this.askTranslationsFor.bind(this))
    Bus.subscribe("got.translation.for.navbar", this.translate.bind(this))
  }

  translate(payload) {
    let key= payload.key
    let label = payload.label
    this.data.translate(key,label)
  }

  askTranslationsFor(payload) {
    let data = {  for: this.element,
                  key: payload.description }
    Bus.publish('ask.translation', data)
  }

  setInfo(payload){
    this.data.setValues(payload)
  }

  retrieve(){
    Bus.publish("get.information")
  }

  initializeViews(){
    let listView =  {
        'asesora-navbar': AsesoraNavbar
      }
    super.initializeViews(listView)

  }

  model(){
    return {
      title: "XXXXXXX",
      version: "Version X.X.X",
      labels: {
        "description": "lorem ipsum dolor lorem ipsum dolor",
        "createSolicitude": "Nueva solicitud",
        "solicitudeList": "Listado de solicitudes"
      },

      setValues:function(values){
        this.title = values.name
        this.descriptionKey = values.description
        this.version = values.version
      },

      translate:function(key,value) {
        this.labels[key] = value
      }
    }
  }
}
