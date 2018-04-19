import Vue from 'vue'
import SolicitudesEditionView from '../views/solicitude/asesora-solicitudes-edition'
import {Bus} from '../bus'

export default class SolicitudesEdition {

  constructor(){
    this.element = 'solicitudes-edition'
    this.data = this.model()
    this.subscribe()
    this.askTranslations()
    this.initializeViews()
    this.watchActions()
  }

  subscribe(){
    Bus.subscribe("translation.for.solicitudes-edition", this.translate.bind(this))
    Bus.subscribe("created.solicitudes-edition", this.createdSolicitude.bind(this))
  }

  watchActions(){
    document.getElementById(this.element).addEventListener(
      'submit.solicitudes-edition',
      this.submit.bind(this)
    )
    window.addEventListener("beforeunload", this.leaving)
  }

  leaving(event){
    var confirmationMessage = "\o/"
    event.returnValue = confirmationMessage
    return confirmationMessage
  }

  submit(){
    Bus.publish('create.solicitudes-edition', this.data.values)
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
        'asesora-solicitudes-edition': SolicitudesEditionView
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
      editionmode: true,
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
