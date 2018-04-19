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
    this.watchActions()
  }

  subscribe(){
    Bus.subscribe("translation.for.solicitude", this.translate.bind(this))
    Bus.subscribe("created.solicitude", this.createdSolicitude.bind(this))
  }

  watchActions(){
    document.getElementById(this.element).addEventListener(
      'submit.solicitude',
      this.submit.bind(this)
    )
  }

  submit(){
    Bus.publish('create.solicitude', this.data.values)
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

  createdSolicitude(){
    this.data.fullfilled = true
  }

  model(){
    return {
      labels: { "applicant": "XXXXXXXX",
                "date": "XXXXX",
                "text": "XXXXX",
                "noDate": "XXXXX",
                "submitting" : "xxxxxxxxxx",
                "submit" : "xxxxxxxxxx" },
      values: { "text": "",
                "date": "",
                "applicant": "" },
      fullfilled: false,
      translate:function(key,value) {
        this.labels[key] = value
      }
    }
  }
}
