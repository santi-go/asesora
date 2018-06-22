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
    Bus.subscribe("delete.solicitude", this.deleteSolicitude.bind(this))
    Bus.subscribe("create.subject", this.createSubject.bind(this))
    Bus.subscribe("get.subjects.list", this.loadSubjects.bind(this))

  }

  retrieveCnae() {
    let callback = this.buildCallback('got.cnae-catalog')
    let body = {}
    let url = 'cnae'
    this.client.hit(url, body, callback)
  }

  createSubject(payload) {
    let callback = this.buildCallback('subject.created')
    let body = payload
    let url = 'create-subject'
    this.client.hit(url, body, callback)
  }

  loadSubjects(payload) {
    let callback = this.buildCallback('got.subjects.list')
    let body = payload
    let url = 'retrieve-subjects'
    this.client.hit(url, body, callback)
  }

  store() {
    return function(response) {
      this.cnaeCatalog = response.data
      Bus.publish("got.cnae-catalog", this.cnaeCatalog)
    }
  }

  deleteSolicitude(payload){
    let callback = this.buildCallback('deleted.solicitude')
    let body = {id: payload}
    let url = 'delete-solicitude'
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
  
  buildCallback(signal){
    return function(response){
      Bus.publish(signal, response)
    }
  }
}
