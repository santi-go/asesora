import {Bus} from '../bus'
import aja from 'aja'

export default class Title {
  constructor() {
    this.baseURL = 'http://localhost:4567/api/'
    this.subscribe()
  }

  subscribe() {
    Bus.subscribe("get.title", this.retrieveTitle.bind(this))
  }

  retrieveTitle(payload) {
    let callback = this.buildCallback('got.title')
    let body = { name: payload }
    let url = 'greet'
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
