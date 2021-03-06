import SolicitudesListView from '../views/solicitude/asesora-solicitudes-list'
import {SolicitudesListModel} from '../models/solicitudes-list'
import Component from '../infrastructure/component'
import {Bus} from '../bus'

export default class SolicitudesList extends Component {
  constructor(){
    super('solicitudes-list')
    this.retrieve()
  }

  subscribe(){
    Bus.subscribe("got.solicitudes-list", this.populateSolicitudeList.bind(this))
    Bus.subscribe("got.translation.for.solicitudes-list", this.translate.bind(this))
  }

  watchActions(){
    document.getElementById(this.element).addEventListener(
      'load.solicitude',
      this.load.bind(this)
    )

    document.getElementById(this.element).addEventListener(
      'show.solicitude',
      this.showSolicitude.bind(this)
    )
  }

  load(event){
    window.location.href = "/index.html?id=" + event.detail
  }

  showSolicitude(event){
    window.location.href = "/show-solicitude.html?id=" + event.detail
  }

  initializeViews(){
    let listView = {
      'asesora-solicitudes-list': SolicitudesListView
    }
    super.initializeViews(listView)
  }

  retrieve(){
    Bus.publish("get.solicitudes.list")
  }

  populateSolicitudeList(payload){
    this.data.solicitudes = payload.data
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

  model(){
    return SolicitudesListModel
  }
}
