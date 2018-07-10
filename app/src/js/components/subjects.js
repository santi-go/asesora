import Component from '../infrastructure/component'
import {Bus} from '../bus'
import {APIClient} from '../infrastructure/api_client'
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
      'clicked.discard.subject.button',
      this.discardCard.bind(this)
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
      topics: payload.detail.topics.map(item => item.value)
    }
    Bus.publish('create.subject', subject)
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
    let catalog = []
    for (const topic of payload.data) {
      catalog.push({ value: topic, text: topic.name })
    }
    this.data.topicsCatalog = catalog
  }

  gotProposalsCatalog(payload) {
    let catalog = []
    for (const proposal of payload.data) {
      catalog.push({ value: proposal, text: proposal })
    }
    this.data.proposalsCatalog = catalog
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
        'subjects': payload.data.subjects
        }
    }

  model(){
    return {
      labels: {
        "proposals": "xxxxx",
        "analysis": "xxxxxx",
        "edit": "xxxxx",
        "addSubject": "XXXXXX",
        "createSubject": "XxX",
        "subjectsData": "xxxxx",
        "topics": "xxxxxx",
        "notApply": "xxxx",
        "placeholderAnalysis": "xxxx",
        "max200Words": "xxxx",
        "discardButtonSubject": "xxxxxx",
        "applicantName": "XXXX",
        "applicantSurname": "XXXXXXXXX",
        "applicantCcaa": "xxxxx",
        "applicantEmail": "XXX",
        "applicantPhonenumber": "XXXXXXXXX",
        "date": "XXXXX",
        "text": "XXXXX",
        "companyName": "XXXXXXXX",
        "companyCif": "XXXXXX",
        "companyEmployees": "XXXXXX",
        "companyCnae": "XXXXXXXX"
      },
      values: {
        "solicitudeId": "",
        "proposals": [],
        "analysis": "",
        "subjectId":"",
        "topics": "",
        "selectedTopics": [],
        "id": "",
        "applicantName": "",
        "applicantSurname": "",
        "applicantCcaa": "",
        "applicantEmail": "",
        "applicantPhonenumber": "",
        "date": "",
        "text": "",
        "companyName": "",
        "companyCif": "",
        "companyEmployees": "",
        "companyCnae": ""
      },
      submittable: false,
      topicsCatalog: [],
      proposalsCatalog: [],
      origin: "none",
      setValues:function(key, value) {
        this.values[key] = value
      },
      translate:function(key,value) {
        this.labels[key] = value
      }
    }
  }
}
