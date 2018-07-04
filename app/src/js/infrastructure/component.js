import Vue from 'vue'

export default class Component {

  constructor(elementName){
    this.element = elementName
    this.data = this.model()
    this.subscribe()
    this.askTranslations()
    this.initializeViews()
    this.watchActions()
  }

  subscribe(){
    console.log('subscribe must be overwritten')
  }

  reactTo(eventName, callback) {
    document.getElementById(this.element).addEventListener(
      eventName,
      callback
    )
  }

  initializeViews(viewList, mountedFunction){
    new Vue({
      el: '#' + this.element,
      data: this.data,
      components: viewList,
      mounted: mountedFunction
    })
  }

  askTranslations() {}


  watchActions(){}

  model(){}
}
