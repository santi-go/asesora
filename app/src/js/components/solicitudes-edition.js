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
    this.load()
  }

  subscribe(){
    Bus.subscribe('got.solicitude', this.updateModel.bind(this))
    Bus.subscribe("updated.solicitude", this.updatedSolicitude.bind(this))
    Bus.subscribe("translation.for.solicitudes-edition", this.translate.bind(this))
  }

  watchActions(){
    document.getElementById(this.element).addEventListener(
      'load.solicitude',
      this.load.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'edit.solicitude',
      this.update.bind(this)
    )
    window.addEventListener("beforeunload", this.leaving.bind(this))
  }

  hasChanges(){
    return this.data.values.applicant.name != this.initialValues.applicant.name || this.data.values.date != this.initialValues.date || this.data.values.text != this.initialValues.text
  }

  leaving(event){
    if(!this.data.showAlert){
      return
    }
    if(this.hasChanges()){
      const confirmationMessage = "\o/"

      event.returnValue = confirmationMessage
      return confirmationMessage
    }
  }

  update(){
    Bus.publish('update.solicitude', this.data.values)
  }

  load(){
    let url = document.URL
    let index = url.indexOf("=")
    let id = url.slice(index + 1)
    Bus.publish('get.solicitude', {id: id})
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
  updateModel(payload) {
    this.initialValues = payload.data
    this.data.setValues('text', payload.data.text)
    this.data.setValues('date', payload.data.date)
    this.data.setValues('applicant', payload.data.applicant.name)
    this.data.setValues('creation_moment',payload.data.creation_moment)
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
              window.location = "/solicitudes-list.html"
            }, 1000)
          }, 1000)
        }.bind(this)),

        this.$on('moveErrorCard', function(){
          let element = this.$el
          window.setTimeout(function(){
            element.style.marginTop = '-1000px'
            window.setTimeout(function(){
              location.reload()
            }, 1000)
          }, 1000)
        }.bind(this)),

        this.$on('discardCard', function(){
          this.$data.showAlert = false
          let element = this.$el
          window.setTimeout(function(){
            element.style.marginTop = '1000px'
            window.setTimeout(function(){
              window.location = "/solicitudes-list.html"
            }, 1000)
          }, 1000)
        }.bind(this))
      }
    })
  }

  updatedSolicitude(response){
    this.data.showAlert = false
    if (Object.keys(response).length === 0){
      this.data.errors = true
    }else{
      this.data.fullfilled = true
    }
  }

  model(){
    return {
      editionmode: true,
      showAlert: true,
      fullfilled: false,
      errors: false,
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
                "applicant": {
                  "name": "",
                  "secondname": "",
                  "email": "",
                  "phonenumber": ""
                },
                "creation_moment": "" },
      translate:function(key,value) {
        this.labels[key] = value
      },
      setValues:function(key, value){
        this.values[key] = value
      }
    }
  }
}
