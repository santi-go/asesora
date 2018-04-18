import Vue from 'vue'
import SolicitudesListView from '../views/asesora-solicitudes-list'
import {Bus} from '../bus'

export default class SolicitudesList {
  constructor(){
    this.element = 'solicitudes-list'
    this.data = this.model()
    this.subscribe()
    this.retrieve()
    this.askTranslations()
    this.initializeViews()
    this.watchActions()
  }

  subscribe(){
    Bus.subscribe("got.solicitudes-list", this.populateSolicitudeList.bind(this))
    Bus.subscribe("translation.for.solicitudes-list", this.translate.bind(this))
  }

  watchActions(){
    document.getElementById(this.element).addEventListener(
      'load.solicitude',
      this.load.bind(this)
    )
  }

  load(event){
    window.location.href = "/solicitude-edit.html?id=" + event.detail
  }

  initializeViews(){
    new Vue({
      el: '#' + this.element,
      data: this.data,
      components: {
        'asesora-solicitudes-list': SolicitudesListView
      }
    })
  }

  retrieve(){
    Bus.publish("get.solicitudes-list")
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
    return {
      labels: { "code": "XXXXXXXX",
                "date": "XXXXX",
                "applicant": "XXXXX",
                "company": "XXXXX",
                "topics": "xxxxxxxxxx" },
      solicitudes: [
        {
          applicant:"qwerty",
          creation_moment:"1523991256366",
          date:"2018-12-31",
          text:"qwertyu"
        },
      ],
      fullfilled: false,
      translate:function(key,value) {
        this.labels[key] = value
      }
    }
  }
}
