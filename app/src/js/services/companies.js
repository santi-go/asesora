import {Bus} from '../bus'
import {APIClient} from '../infrastructure/api_client'

export default class Companies {
  constructor() {
    this.client = APIClient
    this.subscribe()
  }

  subscribe() {
    Bus.subscribe("verify.company.duplicate", this.checkDuplicatedCif.bind(this))
    Bus.subscribe("get.company.matches", this.getCompanyMatches.bind(this))
    Bus.subscribe("update.company", this.updateCompany.bind(this))
    Bus.subscribe("get.company.count", this.getCompanyCount.bind(this))
  }

  updateCompany(payload){
    let callback = this.buildCallback('updated.company')
    let body = payload
    let url = 'update-company'
    this.client.hit(url, body, callback)
  }

  getCompanyMatches(criteria){
    let callback = this.buildCallback('got.company-matches')
    let body = criteria
    let url = 'company-matches'
    this.client.hit(url, body, callback)
  }

  checkDuplicatedCif(payload) {
    let callback = this.buildCallback('verified.company.duplicate')
    let body = {id: payload}
    let url = 'duplicated-company'
    this.client.hit(url, body, callback)
  }

  getCompanyCount(cif){
    let callback = this.buildCallback('got.company.count')
    let body = {cif: cif}
    let url = 'count-company-in-solicitudes'
    this.client.hit(url, body, callback)
  }

  buildCallback(signal){
    return function(response){
      Bus.publish(signal, response)
    }
  }
}
