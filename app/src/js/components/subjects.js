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
  }

  load(){
    this.data.values.solicitudeId = this.getSolicitudeId()
  }

  watchActions(){
    document.getElementById(this.element).addEventListener(
      'clicked.create.counseling',
      this.createCounseling.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'changed.analysis',
      this.setButtonStatus.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'changed.topics',
      this.setButtonStatus.bind(this)
    )
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

  getSolicitudeId() {
    let url = document.URL
    let index = url.indexOf("=")
    let id = url.slice(index + 1)

    return id
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
        "max200Words": "xxxx"
      },
      values: {
        "solicitudeId": "",
        "proposals": [],
        "analysis": "",
        "subjectId":"",
        "topics": "",
        "selectedTopics": []
      },
      submittable: false,
      topicsCatalog: [],
      proposalsCatalog: [],
      translate:function(key,value) {
        this.labels[key] = value
      }
    }
  }
}