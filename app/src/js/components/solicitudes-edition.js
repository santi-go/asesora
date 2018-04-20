import Vue from 'vue'
import SolicitudesEditionView from '../views/solicitude/asesora-solicitudes-edition'
import {Bus} from '../bus'

export default class SolicitudesEdition {

  constructor(){
    this.element = 'solicitudes-edition'
    this.data = this.model()
    this.subscribe()
    this.retrieve()
    this.askTranslations()
    this.initializeViews()
    this.watchActions()
  }

  subscribe(){
    Bus.subscribe("got.solicitudes-list", this.SolicitudeData.bind(this))
    Bus.subscribe("translation.for.solicitudes-edition", this.translate.bind(this))
  }

  watchActions(){
    document.getElementById(this.element).addEventListener(
      'load.solicitude',
      this.load.bind(this)
    )
    window.addEventListener("beforeunload", this.leaving)
  }

  leaving(event){
    var confirmationMessage = "\o/"
    event.returnValue = confirmationMessage
    return confirmationMessage
  }

  load(event){
    window.location.href = "/solicitudes-edition.html?id=" + event.detail
  }

  initializeViews(){
    new Vue({
      el: '#' + this.element,
      data: this.data,
      components: {
        'asesora-solicitudes-edition': SolicitudesEditionView
      }
    })
  }

  retrieve(){
    Bus.publish("get.solicitudes-list")
  }

  SolicitudeData(payload){
    let idPosition = payload.data['data'][]
    console.log(idPosition)
    let id = payload.data['data'][0]['creation_moment']
    console.log(id)
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
        }.bind(this)),

        this.$on('discardCard', function(){
          let element = this.$el
          window.setTimeout(function(){
            element.style.marginTop = '1000px'
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
                "submit" : "xxxxxxxxxx",
                "discard" : "xxxxxxx",
                "discarding" : "xxxxxxxxxx"
               },
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
