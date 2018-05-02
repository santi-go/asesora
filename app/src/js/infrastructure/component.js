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
