import {Bus} from '../bus'
import aja from 'aja'

export default class Translations {
  constructor() {
    this.baseURL = 'http://localhost:4567/api/'
    this.retrieve()
    this.translations = {}
    this.subscriptions()
  }

  subscriptions() {
    Bus.subscribe('ask.translation', this.sendTranslation.bind(this))
  }

  sendTranslation(payload) {
    let key = payload.key
    let data = this.buildTranslation(key)
    Bus.publish('sent.translation', data)
  }

  buildTranslation(key) {
    let translation = {}

    translation = { key: this.translations[key] }

    if (!this.translations[key]) {
      translation = { translation: key }
    }

    return translation
  }

  retrieve() {
    let callback = this.store()
    let body = { locale: 'es' }
    let url = 'translations'
    this.hit(url, body, callback)
  }

  store(){
    return function(response) {
      this.translations = response.data
    }.bind(this)
  }

  hit(endpoint, data, action){
    aja()
      .method('post')
      .body(data)
      .url(this.baseURL + endpoint)
      .on('success', action)
    .go();
  }
}
