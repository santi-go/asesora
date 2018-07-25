import Component from '../infrastructure/component'
import {Bus} from '../bus'
import {APIClient} from '../infrastructure/api_client'
import {SubjectsModel} from '../models/subjects'
import SubjectsView from '../views/solicitude/asesora-subjects'


export default class Subjects extends Component {

  constructor(){
    super('subjects')
    this.client = APIClient
    this.load()
  }

  subscribe(){
    Bus.subscribe("got.translation.for.subjects", this.translate.bind(this))
    Bus.subscribe("subject.created", this.subjectCreated.bind(this))
    Bus.subscribe("got.topics-catalog", this.gotTopicsCatalog.bind(this))
    Bus.subscribe("got.proposals-catalog", this.gotProposalsCatalog.bind(this))
    Bus.subscribe("got.solicitude", this.updateModel.bind(this))
    Bus.subscribe("got.reasons-catalog", this.gotReasonsCatalog.bind(this))
    Bus.subscribe("subject.closed", this.subjectClosed.bind(this))
    Bus.subscribe("deleted.subject", this.deletedSubject.bind(this))
  }

  load(){
    this.data.values.solicitudeId = this.getSolicitudeId()
    Bus.publish('get.solicitude', {id: this.data.values.solicitudeId})
  }

  watchActions(){
    document.getElementById(this.element).addEventListener(
      'clicked.create.counseling',
      this.createCounseling.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'changed.subject',
      this.setButtonStatus.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'changed.subject',
      this.warningRequired.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'clicked.discard.subject.button',
      this.discardCard.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'clicked.close.counseling',
      this.closeCounseling.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'clicked.delete.subject',
      this.deleteSubject.bind(this)
    )
  }

  getSolicitudeId() {
    let url = document.URL
    let urlSplitted = url.split('=')
    let id = urlSplitted[1]
    this.origin = urlSplitted[2]
    return id
  }

  discardCard(event){
    let url = ""

    if (this.origin == "show") {
      url =  "/show-solicitude.html?id=" + this.data.values.solicitudeId
    }
    if (this.origin == "edit") {
      url =  "/index.html?id=" + this.data.values.solicitudeId
    }
    this.moveCardAnimation('discardCard')
    this.setTimeToRelocateUrl(url)
  }

  moveCardAnimation(cssClass){
    let element = document.querySelector('#subjects')
    element.classList.add(cssClass)
  }

  setTimeToRelocateUrl(url) {
    window.setTimeout(function(){
      window.location = url
    }, 1250)
  }

  initializeViews(){
    let listView = {
      'asesora-subjects': SubjectsView,
    }
    super.initializeViews(listView)
  }

  askTranslations() {
    let labelKeys = Object.keys(this.model().labels)
    for (const labelKey of labelKeys) {
      let data = {  for: this.element,
        key: labelKey }
        Bus.publish('ask.translation', data)
      }
    }

  deletedSubject(payload){
    let id = payload.data.id
    let subjects = this.data.values.subjects
    this.data.values.subjects = subjects.filter(function(subject){
      return subject.id != id
    })
  }

  translate(payload) {
    let key = payload.key
    let label = payload.label
    this.data.translate(key,label)
  }

  createCounseling(payload) {
    const subject = {
      solicitudeId: payload.detail.solicitudeId,
      proposal: payload.detail.proposals.map(item => item.value),
      analysis: payload.detail.analysis,
      description: payload.detail.description,
      topics: payload.detail.topics.map(item => item.value),
      comments: payload.detail.comments,
      reason: payload.detail.reason
    }
    Bus.publish('create.subject', subject)
  }

  subjectClosed(payload){
    window.location.href = "/show-solicitude.html?id=" + payload.solicitude_id
  }

  closeCounseling(payload) {
    const subject = {
      subjectId: payload.detail.subjectId,
      solicitudeId: payload.detail.solicitudeId,
      proposal: payload.detail.proposals.map(item => item.value),
      description: payload.detail.description,
      analysis: payload.detail.analysis,
      topics: payload.detail.topics.map(item => item.value),
      comments: payload.detail.comments,
      reason: payload.detail.reason,
      closed: payload.detail.closed
    }
    Bus.publish('close.subject', subject)
  }

  deleteSubject(payload){
    if (!confirm("¿Estas seguro/a de que quieres eliminar el caso asociado? Ten en cuenta que esta operación no se puede deshacer")){
      return
    }
    Bus.publish('delete.subject', payload.detail)
  }

  setButtonStatus(){
    this.data.submittable = false
    let analysis = (this.data.values.analysis != "")
    let topics = (this.data.values.selectedTopics.length > 0)
    if(analysis || topics){
      this.data.submittable = true
    }
  }

  subjectCreated(payload) {
    window.location.href = "/show-solicitude.html?id=" + payload.solicitude_id
  }

  gotTopicsCatalog(payload) {
    this.data.topicsCatalog = payload.data
  }

  gotProposalsCatalog(payload) {
    let catalog = []
    for (const proposal of payload.data) {
      catalog.push({ value: proposal, text: proposal })
    }
    this.data.proposalsCatalog = catalog
  }

  gotReasonsCatalog(payload) {
    let catalog = []
    for (const reason of payload.data) {
      catalog.push({ value: reason.id, text: reason.name })
    }
    this.data.reasonsCatalog = catalog
    this.data.values.reason = catalog[0]
  }

  updateModel(payload){
    this.data.values.id = payload.data.creation_moment

    let dictionary = this.dictionaryOfSolicitude(payload)
     for (let [labelKey, valueKey] of Object.entries(dictionary)) {
       this.data.setValues(labelKey, valueKey)
     }
  }

  dictionaryOfSolicitude(payload){
    return {
        'text': payload.data.text,
        'date': payload.data.date,
        'applicantName': payload.data.applicant_name,
        'applicantSurname': payload.data.applicant_surname,
        'applicantCcaa': payload.data.applicant_ccaa,
        'applicantEmail': payload.data.applicant_email,
        'applicantPhonenumber': payload.data.applicant_phonenumber,
        'companyName': payload.data.company_name,
        'companyCif': payload.data.company_cif,
        'companyEmployees': payload.data.company_employees,
        'companyCnae': payload.data.company_cnae,
        'subjects': payload.data.subjects,
        'source': payload.data.source
      }
  }

  warningRequired(){
    this.data.warningSubject = true

    if(this.data.values.selectedTopics.length > 0 &&
       this.data.values.proposals.length > 0){

      this.data.warningSubject = false
    }
  }

  model(){
    return SubjectsModel
  }
}
