export default class Component {

  constructor(elementName){
    this.element = elementName
    this.data = this.model()
    this.subscribe()
    this.askTranslations()
    this.initializeViews()
    this.watchActions()
  }

  subscribe(){}

  askTranslations() {}

  initializeViews(){}

  watchActions(){}

  model(){}
}
