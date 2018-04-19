import Vue from 'vue'
import AsesoraSidebar from '../views/asesora-sidebar'
import {Bus} from '../bus'

export default class Sidebar {

  constructor(){
    this.element = 'sidebar'
    this.data = this.model()
    this.subscribe()
    this.askTranslations()
    this.initializeViews()
  }

  subscribe(){
    Bus.subscribe("translation.for.sidebar", this.translate.bind(this))
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
    new Vue({
      el: '#' + this.element,
      data: this.data,
      components: {
        'asesora-sidebar': AsesoraSidebar
      }
    })
  }

  model(){
    return {
      labels: {
        "createSolicitude": "XXXXXXXXXXXXXXX",
        "solicitudeList": "XXXXXXX"
      },

      translate:function(key,value) {
        this.labels[key] = value
      }
    }
  }
}