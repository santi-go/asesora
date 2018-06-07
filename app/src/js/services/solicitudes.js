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
    Bus.subscribe("get.solicitudes.list", this.getSolicitudesList.bind(this))
    Bus.subscribe("get.solicitude", this.getSolicitude.bind(this))
    Bus.subscribe("create.solicitude", this.createSolicitude.bind(this))
    Bus.subscribe("update.solicitude", this.updateSolicitude.bind(this))
    Bus.subscribe("update.applicant", this.updateApplicant.bind(this))
    Bus.subscribe("verify.company.duplicate", this.checkDuplicatedCif.bind(this))
    Bus.subscribe("get.company.matches", this.getCompanyMatches.bind(this))
    Bus.subscribe("get.applicant.matches", this.getSuggestedApplicants.bind(this))
    Bus.subscribe("update.company", this.updateCompany.bind(this))
    Bus.subscribe("get.company.count", this.getCompanyCount.bind(this))
  }

  retrieveCnae() {
    let callback = this.buildCallback('got.cnae-catalog')
    let body = {}
    let url = 'cnae'
    this.client.hit(url, body, callback)
  }

  updateCompany(payload){
    let callback = this.buildCallback('updated.company')
    let body = payload
    let url = 'update-company'
    this.client.hit(url, body, callback)
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

  updateApplicant(payload){
    let callback = this.buildCallback('updated.applicant')
    let body = payload
    let url = 'update-applicant'
    this.client.hit(url, body, callback)
  }

  checkDuplicatedCif(payload) {
    let callback = this.buildCallback('verified.company.duplicate')
    let body = {id: payload}
    let url = 'duplicated-company'
    this.client.hit(url, body, callback)
  }

  getSuggestedApplicants(criteria){
    let callback = this.buildCallback('got.applicant.matches')
    let body = criteria
    let url = 'applicant-matches'
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
