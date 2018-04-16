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
        'asesora-solicitude': SolicitudeView
      },
      mounted: function() {
        this.$on('moveCard', function(){
          let element = this.$el
          window.setTimeout(function(){
            element.style.marginTop = '-1000px'
            window.setTimeout(function(){
              location.reload()
            }, 1000)
          }, 1000)
        }.bind(this))
      }
    })
  }

  model(){
    return {
      labels: { "applicant": "XXXXXXXX",
                "date": "fecha",
                "text": "XXXXX",
                "noDate": 'XXXXX' },
      values: { "text": "",
                "date": "",
                "applicant": "" },
      translate:function(key,value) {
        this.labels[key] = value
      }
    }
  }
}
