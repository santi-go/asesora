import Vue from 'vue'
import Title from '../views/title-asesora'
import {Bus} from '../bus'

export default class App {

  constructor(elementID){
    this.element = 'asesora'
    this.data = this.model()
    this.subscribe()
    this.retrieveData()
    this.initializeViews()
  }

  subscribe(){
    Bus.subscribe("got.title", this.setValues.bind(this))
  }

  setValues(payload){
    this.data.setValues(payload)
  }

  retrieveData(){
    let title = "Asesora"
    Bus.publish("get.title", title)
  }

  initializeViews(){
    new Vue({
      el: '#' + this.element,
      data: this.data,
      components: {
        'title-asesora': Title,
      }
    })
  }

  model(){
    return {
      title: "ASESORA",
      setValues:function(values){
        this.title = values
      }
    }
  }
}
