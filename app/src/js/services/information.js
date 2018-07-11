import {Bus} from '../bus'
import {APIClient} from '../infrastructure/api_client'


export default class Information {
  constructor() {
    this.client = APIClient
    this.subscribe()
  }

  subscribe() {
    Bus.subscribe("get.information", this.retrieveNavbar.bind(this))
  }

  retrieveNavbar(payload) {
    let callback = this.buildCallback('got.information')
    let body = {}
    let url = 'navbar'
    this.client.hit(url, body, callback)
  }

  buildCallback(signal){
    return function(response){
      Bus.publish(signal, response)
    }
  }
}
