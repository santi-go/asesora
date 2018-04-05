import {Bus} from '../bus'
import aja from 'aja'

export default class Translations {
  constructor() {
    this.baseURL = 'http://localhost:4567/api/'
    this.retrieve()
    this.translations = {}
  }

  retrieve() {
    let callback = this.store()
    let body = { locale: 'es' }
    let url = 'translations'
    this.hit(url, body, callback)
  }

  store(response){
    return function() {
      let locale = this.getLocale(response)
      this.translations[locale] = response[locale]
    }.bind(this)
  }

  getLocale(response){
    return Object.keys(response)[0]
  }

  hit(endpoint, data, action){
    aja()
      .method('post')
      .body(data)
      .url(this.baseURL + endpoint)
      .on('success', action)
      .on('40x', this.store({}))
    .go();
  }
}
