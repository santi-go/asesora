import {Bus} from '../bus'
import {APIClient} from '../infrastructure/api_client'

export default class Solicitudes {
  constructor() {
    this.client = APIClient
    this.subscribe()
    this.retrieveCnae()
    this.cnaeCatalog = []
    this.retrieveTopics()
    this.topicsCatalog = []
    this.retrieveProposals()
    this.proposalsCatalog = []
  }

  subscribe() {
    Bus.subscribe("get.solicitudes.list", this.getSolicitudesList.bind(this))
    Bus.subscribe("get.solicitude", this.getSolicitude.bind(this))
    Bus.subscribe("create.solicitude", this.createSolicitude.bind(this))
    Bus.subscribe("create.solicitude.to.add.subject", this.createSolicitudeToAddSubject.bind(this))
    Bus.subscribe("update.solicitude", this.updateSolicitude.bind(this))
    Bus.subscribe("update.solicitude.and.add.subject", this.updateSolicitudeAndAddSubject.bind(this))
    Bus.subscribe("delete.solicitude", this.deleteSolicitude.bind(this))
    Bus.subscribe("create.subject", this.createSubject.bind(this))
  }

  retrieveCnae() {
    let callback = this.buildCallback('got.cnae-catalog')
    let body = {}
    let url = 'cnae'
    this.client.hit(url, body, callback)
  }

  retrieveProposals() {
    let callback = this.buildCallback('got.proposals-catalog')
    let body = {}
    let url = 'proposals'
    this.client.hit(url, body, callback)
  }

  retrieveTopics() {
    let callback = this.buildCallback('got.topics-catalog')
    let body = {}
    let url = 'topics'
    this.client.hit(url, body, callback)
  }

  createSubject(payload) {
    let callback = this.buildCallback('subject.created')
    let body = payload
    let url = 'create-subject'
    this.client.hit(url, body, callback)
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

  createSolicitudeToAddSubject(payload) {
    let callback = this.buildCallback('created.solicitude.to.add.subject')
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

  updateSolicitudeAndAddSubject(payload) {
    let callback = this.buildCallback('updated.solicitude.and.add.subject')
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
