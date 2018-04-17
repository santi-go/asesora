import {Bus} from '../bus'
import {APIClient} from '../infrastructure/api_client'


export default class Translations {
  constructor() {
    this.client = APIClient
    this.retrieve()
    this.loaded = false
    this.pending = []
    this.translations = {}
    this.subscriptions()
  }

  subscriptions() {
    Bus.subscribe('ask.translation', this.sendTranslation.bind(this))
  }

  sendTranslation(payload) {
    if (!this.loaded){
        this.pending.push(payload)
        return
    }
    let key = payload.key
    let component= payload.for
    let data = this.buildTranslation(component, key)
    Bus.publish('translation.for.'+ component, data)
  }

  buildTranslation(component, key) {
    let translation = {}
    translation = { 'key': key,
                    'label': this.translations[component][key]}

    if (!this.translations[component][key]) {
      translation['label'] = component + '.' + key
    }

    return translation
  }

  retrieve() {
    let callback = this.store()
    let body = { locale: 'es' }
    let url = 'translations'
    this.client.hit(url, body, callback)
  }

  store(){
    return function(response) {
      this.translations = response.data
      this.loaded = true
      this.processPending()
    }.bind(this)
  }

  processPending(){
    for (let payload of this.pending) {
      this.sendTranslation(payload)
    }
    this.pending=[]
  }
}
