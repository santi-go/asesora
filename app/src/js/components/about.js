import Vue from 'vue'
import AsesoraAbout from '../views/asesora-about'
import Component from '../infrastructure/component'
import {Bus} from '../bus'

export default class About extends Component{

  constructor(){
    super('about')
    this.retrieve()
  }

  subscribe(){
    Bus.subscribe("got.information", this.setInfo.bind(this))
    Bus.subscribe("got.information", this.askTranslationsFor.bind(this))
    Bus.subscribe("translation.for.about", this.translate.bind(this))
  }

  translate(payload) {
    let key= payload.key
    let label = payload.label
    this.data.translate(key,label)
  }

  askTranslationsFor(payload) {
    let data = {  for: this.element,
                  key: payload.description }
    Bus.publish('ask.translation', data)
  }

  setInfo(payload){
    this.data.setValues(payload)
  }

  retrieve(){
    Bus.publish("get.information")
  }

  initializeViews(){
    new Vue({
      el: '#' + this.element,
      data: this.data,
      components: {
        'asesora-about': AsesoraAbout
      }
    })
  }

  model(){
    return {
      title: "XXXXXXX",
      version: "Version X.X.X",
      labels: {"description": "lorem ipsum dolor lorem ipsum dolor"},

      setValues:function(values){
        this.title = values.name
        this.descriptionKey = values.description
        this.version = values.version
      },

      translate:function(key,value) {
        this.labels[key] = value
      }
    }
  }
}
