import {Bus} from '../bus'
import {APIClient} from '../infrastructure/api_client'

export default class Applicants {
  constructor() {
    this.client = APIClient
    this.subscribe()
    this.getCcaaCatalog()
    this.ccaaCatalog = []
  }

  subscribe() {
    Bus.subscribe("update.applicant", this.updateApplicant.bind(this))
    Bus.subscribe("get.applicant.matches", this.getSuggestedApplicants.bind(this))
  }

  updateApplicant(payload){
    let callback = this.buildCallback('updated.applicant')
    let body = payload
    let url = 'update-applicant'
    this.client.hit(url, body, callback)
  }

  getSuggestedApplicants(criteria){
    let callback = this.buildCallback('got.applicant.matches')
    let body = criteria
    let url = 'applicant-matches'
    this.client.hit(url, body, callback)
  }

  getCcaaCatalog(){
    let callback = this.buildCallback('got.ccaa-catalog')
    let body = {}
    let url = 'ccaa'
    this.client.hit(url, body, callback)
  }

  buildCallback(signal){
    return function(response){
      Bus.publish(signal, response)
    }
  }
}
