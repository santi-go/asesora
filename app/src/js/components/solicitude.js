import Vue from 'vue'
import SolicitudeView from '../views/asesora-solicitude'
import {Bus} from '../bus'

export default class Solicitude {

  constructor(){
    this.element = 'solicitude'
    this.data = this.model()
    this.subscribe()
    this.askTranslations()
    this.askTranslationsText()
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
    let labelKeys = ["applicant", "date"]
    for (const labelKey of labelKeys) {
      let data = {  for: this.element,
                    key: labelKey }
      Bus.publish('ask.translation', data)
    }
  }

  askTranslationsText() {
    let data = {  for: this.element,
                  key: "text" }
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
      labels: { "applicant": "XXXXXXXX",
                "date": "fecha",
                "text": "XXXXX" },
      values: { "text": "",
                "date": "" },
      translate:function(key,value) {
        this.labels[key] = value
      }
    }
  }
}
