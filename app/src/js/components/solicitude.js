import Vue from 'vue'
import SolicitudeView from '../views/asesora-solicitude'
import {Bus} from '../bus'

export default class Solicitude {

  constructor(){
    this.element = 'solicitude'
    this.data = this.model()
    this.subscribe()
    this.askTranslations()
    this.initializeViews()
  }

  subscribe(){
    Bus.subscribe("translation.for.solicitude", this.translate.bind(this))
  }

  translate(payload) {
    let key= payload.key
    let label = payload.label
    this.data.translate(key,label)
  }

  askTranslations() {
    let data = {  for: this.element,
                  key: "applicant" }
    Bus.publish('ask.translation', data)
  }


  initializeViews(){
    new Vue({
      el: '#' + this.element,
      data: this.data,
      components: {
        'asesora-solicitude': SolicitudeView
      }
    })
  }

  model(){
    return {
      labels: {"applicant": "El aplicante"},

      translate:function(key,value) {
        this.labels[key] = value
      }
    }
  }
}
