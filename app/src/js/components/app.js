import Vue from 'vue'
import AsesoraTitle from '../views/asesora-title'
import AsesoraDescription from '../views/asesora-description'
import AsesoraVersion from '../views/asesora-version'
import {Bus} from '../bus'

export default class App {

  constructor(elementID){
    this.element = 'asesora'
    this.data = this.model()
    this.subscribe()
    this.retrieveAbout()
    this.initializeViews()
  }

  subscribe(){
    Bus.subscribe("got.information", this.setAboutInfo.bind(this))
  }

  setAboutInfo(payload){
    this.data.setValues(payload)
  }

  retrieveAbout(){
    Bus.publish("get.information")
  }

  initializeViews(){
    new Vue({
      el: '#' + this.element,
      data: this.data,
      components: {
        'asesora-title': AsesoraTitle,
        'asesora-description': AsesoraDescription,
        'asesora-version': AsesoraVersion
      }
    })
  }

  model(){
    return {
      title: "ASESORA",
      description: 'Registro de asesoramientos técnicos en salud laboral',
      version: "Version 0.0.0",
      setValues:function(values){
        this.title = values.name
        this.description = values.description
        this.version = values.version
      }
    }
  }
}
