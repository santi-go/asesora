import {Bus} from '../bus'
import {APIClient} from '../infrastructure/api_client'

export default class Solicitudes {
  constructor() {
    this.client = APIClient
    this.subscribe()
    this.retrieveCnae()
    this.cnaeCatalog = []
  }

  subscribe() {
    Bus.subscribe("get.solicitudes-list", this.getSolicitudesList.bind(this))
    Bus.subscribe("get.solicitude", this.getSolicitude.bind(this))
    Bus.subscribe("create.solicitude", this.createSolicitude.bind(this))
    Bus.subscribe("update.solicitude", this.updateSolicitude.bind(this))
    Bus.subscribe("verify.company.duplicate", this.duplicatedCif.bind(this))
    Bus.subscribe("search.company.matches", this.getCompanyMatches.bind(this))
    Bus.subscribe("ask.suggested.applicants", this.getSuggestedApplicants.bind(this))
  }

  retrieveCnae() {
    let callback = this.store()
    let body = {}
    let url = 'cnae'
    this.client.hit(url, body, callback)
  }

  store() {
    return function(response) {
      this.cnaeCatalog = response.data
      Bus.publish("got.cnae-catalog", this.cnaeCatalog)
    }
  }

  getSolicitudesList() {
    let callback = this.buildCallback('got.solicitudes-list')
    let body = {}
    let url = 'retrieve-solicitudes'
    this.client.hit(url, body, callback)
  }

  getSolicitude(data){
    let callback = this.buildCallback('got.solicitude')
    let body = {id: data.id}
    let url = 'retrieve-solicitude'
    this.client.hit(url, body, callback)
  }

  getCompanyMatches(criteria){
    let callback = this.buildCallback('got.company-matches')
    let body = criteria
    let url = 'company-matches'
    this.client.hit(url, body, callback)
  }

  createSolicitude(payload) {
    let callback = this.buildCallback('created.solicitude')
    let body = payload
    let url = 'create-solicitude'
    this.client.hit(url, body, callback)
  }

  updateSolicitude(payload) {
    let callback = this.buildCallback('updated.solicitude')
    let body = payload
    let url = 'update-solicitude'
    this.client.hit(url, body, callback)
  }

  duplicatedCif(payload) {
    let callback = this.buildCallback('verified.company.duplicate')
    let body = {id: payload}
    let url = 'duplicated-company'
    this.client.hit(url, body, callback)
  }

  getSuggestedApplicants(criteria){
    let callback = this.buildCallback('got.suggested-applicants')
    let body = criteria
    let url = 'suggested-applicants'
    this.client.hit(url, body, callback)
  }

  buildCallback(signal){
    return function(response){
      Bus.publish(signal, response)
    }
  }
}
