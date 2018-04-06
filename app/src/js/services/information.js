import {Bus} from '../bus'

export default class Information {
  constructor(client) {
    this.client = client
    this.subscribe()
  }

  subscribe() {
    Bus.subscribe("get.information", this.retrieveAbout.bind(this))
  }

  retrieveAbout(payload) {
    let callback = this.buildCallback('got.information')
    let body = {}
    let url = 'about'
    this.client.hit(url, body, callback)
  }

  buildCallback(signal){
    return function(response){
      Bus.publish(signal, response)
    }
  }
}
