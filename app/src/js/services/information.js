import {Bus} from '../bus'
import aja from 'aja'

export default class Information {
  constructor() {
    this.baseURL = 'http://localhost:4567/api/'
    this.subscribe()
  }

  subscribe() {
    Bus.subscribe("get.information", this.retrieveAbout.bind(this))
  }

  retrieveAbout(payload) {
    let callback = this.buildCallback('got.information')
    let body = {}
    let url = 'about'
    this.hit(url, body, callback)
  }

  buildCallback(signal){
    return function(response){
      Bus.publish(signal, response)
    }
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
