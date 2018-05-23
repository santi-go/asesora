import SolicitudeView from '../views/solicitude/asesora-solicitude'
import {ValidationCif} from '../library/validation-cif'
import Component from '../infrastructure/component'
import {Bus} from '../bus'
import {APIClient} from '../infrastructure/api_client'

export default class Solicitude extends Component {

  constructor(){
    super('solicitude')
    this.validationCif = ValidationCif
    this.client = APIClient
    this.validEmail = false
    this.validPhonenumber = false
    this.initialValues = this.data.cloneValues()
    this.load()
  }

  subscribe(){
    Bus.subscribe("got.translation.for.solicitude", this.translate.bind(this))
    Bus.subscribe("created.solicitude", this.createdSolicitude.bind(this))
    Bus.subscribe("updated.solicitude", this.updatedSolicitude.bind(this))
    Bus.subscribe("got.cnae-catalog", this.gotCnaeCatalog.bind(this))
    Bus.subscribe("verified.company.duplicate", this.showDuplicate.bind(this))
    Bus.subscribe("got.company-matches", this.populateSuggestedCompanies.bind(this))
    Bus.subscribe('got.solicitude', this.updateModel.bind(this))
    Bus.subscribe("got.applicant.matches", this.populateSuggestedApplicants.bind(this))
  }

  watchActions(){
    document.getElementById(this.element).addEventListener(
      'submit.solicitude',
      this.submit.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'ensure.cif',
      this.ensureCif.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'search.companies',
      this.searchCompanies.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'clicked.company',
      this.fillCompany.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'clicked.applicant',
      this.fillApplicant.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'validate.company.identity',
      this.toggleCompanyIdentityMessage.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'check.submittable',
      this.setButtonStatus.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'changed.email',
      this.setValidEmail.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'changed.phone',
      this.setValidPhone.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'changed.text',
      this.setButtonStatus.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'edit.solicitude',
      this.update.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'clicked.discard.button',
      this.discardAnimation.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'fullfilled.solicitude',
      this.moveCardAnimation.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'changed.applicant.fields',
      this.searchForApplicants.bind(this)
    )
    window.addEventListener("beforeunload", this.leaving.bind(this))
  }

  initializeViews(){
    let listView = {
      'asesora-solicitude': SolicitudeView
    }
    let mounted =function() {}
    super.initializeViews(listView, mounted)
  }

  load(){
    let url = document.URL
    let index = url.indexOf("=")
    let id = url.slice(index + 1)
    if (index == -1){
      id = ""
      this.data.editionmode = false
    } else {
      this.data.editionmode = true
      Bus.publish('get.solicitude', {id: id})
    }
  }

  leaving(event){
    if(!this.data.showAlert){
      return
    }
    if(this.hasChanges()){
      const confirmationMessage = "\o/"

      event.returnValue = confirmationMessage
      return confirmationMessage
    }
  }

  hasChanges(){
    for(let key in this.data.values){
      if (this.data.values[key] != this.initialValues[key]) return true
    }
    return false
  }

  submit(){
    Bus.publish('create.solicitude', this.data.values)
  }

  update(){
    Bus.publish('update.solicitude', this.data.values )
  }

  updatedSolicitude(response){
    this.data.showAlert = false
    if (Object.keys(response).length === 0){
      this.data.errors = true
    }else{
      this.data.fullfilled = true
    }
  }

  updateModel(payload) {
    this.data.setValues('text', payload.data.text)
    this.data.setValues('date', payload.data.date)
    this.data.setValues('name', payload.data.name)
    this.data.setValues('surname', payload.data.surname)
    this.data.setValues('email', payload.data.email)
    this.data.setValues('phonenumber', payload.data.phonenumber)
    this.data.setValues('creation_moment',payload.data.creation_moment)
    this.data.setValues('companyName',payload.data.company_name)
    this.data.setValues('companyCif',payload.data.company_cif)
    this.data.setValues('companyEmployees',payload.data.company_employees)
    this.data.setValues('companyCnae',payload.data.company_cnae)
    this.initialValues = this.data.cloneValues()
  }

  isCifEmpty(){
    return this.data.values.companyCif == ""
  }

  ensureCif(){
    if(this.isCifEmpty()) {
      this.data.isValidCif = true
      return
    }
    this.data.isValidCif = this.validateCif()
    if(this.data.isValidCif){ this.verifyDuplicatedCif() }
  }

  validateCif(){
    return this.validationCif.validate(this.data.values.companyCif)
  }

  verifyDuplicatedCif() {
    let cif = this.data.values.companyCif
    Bus.publish('verify.company.duplicate', cif)
  }

  searchCompanies(event){
    this.data.suggestedCompanies = []
    if(this.hasRequiredLength()){
      Bus.publish('get.company.matches', event.detail)
    }
  }

  hasRequiredLength(){
    let minNumberOfChars = 3
    if(this.data.values.companyName.length >= minNumberOfChars){
      return true
    }
    return false
  }

  populateSuggestedCompanies(payload){
    this.data.suggestedCompanies = payload.data
  }

  showDuplicate(payload) {
    let duplicatedCompany =[]
    if ( !this.isObjectEmpty(payload) ) {
      duplicatedCompany.push(payload)
    }
    this.data.suggestedCompanies = duplicatedCompany
  }

  isObjectEmpty(object){
    return Object.keys(object).length == 0
  }

  fillCompany(item){
    this.data.setValues('companyName', item.detail.name)
    this.data.setValues('companyCif', item.detail.cif)
    this.data.setValues('companyEmployees', item.detail.employees)
    this.data.setValues('companyCnae', item.detail.cnae)
  }

  fillApplicant(item){
    this.data.setValues('name', item.detail.name)
    this.data.setValues('surname', item.detail.surname)
    this.data.setValues('email', item.detail.email)
    this.data.setValues('phonenumber', item.detail.phonenumber)
    this.data.setValues('applicantId', item.detail.id)
    this.data.isValidContact = true
  }

  toggleCompanyIdentityMessage(){
    this.data.isValidCompanyIdentity = false
    if(this.isNameEmpty() && this.isCifEmpty()){
      this.data.isValidCompanyIdentity = true
    }
    if(!this.isNameEmpty() && !this.isCifEmpty() && this.data.isValidCif){
      this.data.isValidCompanyIdentity = true
    }
    this.setButtonStatus()

  }

  isNameEmpty(){
    return this.data.values.companyName === ""
  }

  isCifEmpty() {
    return this.data.values.companyCif === ""
  }

  translate(payload) {
    let key = payload.key
    let label = payload.label
    this.data.translate(key,label)
  }

  askTranslations() {
    let labelKeys = Object.keys(this.model().labels)
    for (const labelKey of labelKeys) {
      let data = {  for: this.element,
        key: labelKey }
        Bus.publish('ask.translation', data)
      }
    }

    gotCnaeCatalog(payload) {
      this.data.cnaeCatalog = payload
    }

    discardAnimation(){
      this.data.showAlert = false
      let element = document.querySelector('#solicitude')
      element.classList.add('discardCard')
      window.setTimeout(function(){
        window.location = "/solicitudes-list.html"
      }, 1250)
    }

    moveCardAnimation(){
      this.initialValues = this.data.cloneValues()
      let element = document.querySelector('#solicitude')
      element.classList.add('submitCard')
      window.setTimeout(function(){
        window.location = "/solicitudes-list.html"
      }, 1250)
    }

    createdSolicitude(){
      this.data.fullfilled = true
    }

    textIsEmpty(){
      return (this.data.values.text == "")
    }

    setButtonStatus(){
      this.data.submittable = false
      if (!this.textIsEmpty() && this.data.isValidContact && this.data.isValidCompanyIdentity) {
        this.data.submittable = true
      }
    }

    validateContact(){
      this.data.isValidContact = this.validEmail || this.validPhonenumber
    }

    setValidEmail(event){
      this.validEmail = event.detail.valid
      this.validateContact()
    }

    setValidPhone(event){
      this.validPhonenumber = event.detail.valid
      this.validateContact()
    }

    searchForApplicants(){
      this.data.values.applicantId = ""
      this.data.suggestedApplicants = []
      let criteria = {
        'name': this.data.values.name,
        'surname': this.data.values.surname,
        'phonenumber': this.data.values.phonenumber,
        'email': this.data.values.email
      }
      if (this.evaluateCriterion(criteria)){
        Bus.publish('get.applicant.matches', criteria)
      }
    }

    evaluateCriterion(criteria){
      for (let field in criteria) {
        if (this.checkMinimunCriteria(criteria[field])){
          return true
        }
      }
      return false
    }

    checkMinimunCriteria(field){
      let minimunLength = 3
      return (field.length >= minimunLength)
    }

    populateSuggestedApplicants(payload){
      this.data.suggestedApplicants = payload.data
    }

    model(){
      return {
        labels: { "applicant": "XXXXXXXX",
        "date": "XXXXX",
        "email": "XXX",
        "phonenumber": "XXXXXXXXX",
        "name": "XXXX",
        "surname": "XXXXXXXXX",
        "text": "XXXXX",
        "noDate": "XXXXX",
        "company": "XXXXXXX",
        "companyName": "XXXXXXXX",
        "companyCif": "XXXXXX",
        "companyEmployees": "XXXXXX",
        "companyCnae": "XXXXXXXX",
        "noContact": "XXXXX",
        "incompleteCompanyIdentity": "XXXXXXX",
        "suggestions" : "xxxxxx",
        "submit" : "xxxxxxxxxx",
        "submitting" : "xxxxxxxxxx",
        "editiondiscard" : "xxxxxxxxxx",
        "editionsubmit" : "xxxxxx",
        "editionsubmitting" : "xxxxxx",
        "sent" : "XXXX"},
        values: { "text": "",
        "date": "",
        "name": "",
        "surname": "",
        "email": "",
        "phonenumber": "",
        "applicantId": "",
        "companyName": "",
        "companyCif": "",
        "companyEmployees": "",
        "companyCnae": "",
        "suggestions" : ""
      },
      suggestedCompanies: [],
      suggestedApplicants: [],
      fullfilled: false,
      isValidCif: true,
      cnaeCatalog:[],
      isValidCompanyIdentity: true,
      isValidContact: true,
      submittable: false,
      showAlert: true,
      editionmode: false,
      translate:function(key,value) {
        this.labels[key] = value
      },
      setValues:function(key, value) {
        this.values[key] = value
      },
      cloneValues:function(){
        let clone = Object.assign({}, this.values)
        return clone
      }
    }
  }
}
