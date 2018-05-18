import SolicitudeView from '../views/solicitude/asesora-solicitude'
import ValidationCif from '../library/validation-cif'
import Component from '../infrastructure/component'
import {Bus} from '../bus'
import {APIClient} from '../infrastructure/api_client'

export default class Solicitude extends Component {

  constructor(){
    super('solicitude')
    this.client = APIClient
    this.validEmail = false
    this.validPhonenumber = false
    this.load()
  }

  subscribe(){
    Bus.subscribe("translation.for.solicitude", this.translate.bind(this))
    Bus.subscribe("created.solicitude", this.createdSolicitude.bind(this))
    Bus.subscribe("updated.solicitude", this.updatedSolicitude.bind(this))
    Bus.subscribe("got.cnae-catalog", this.gotCnaeCatalog.bind(this))
    Bus.subscribe("verified.company.duplicate", this.showDuplicate.bind(this))
    Bus.subscribe("got.company-matches", this.populateSuggestedCompanies.bind(this))
    Bus.subscribe('got.solicitude', this.updateModel.bind(this))
  }

  watchActions(){
    document.getElementById(this.element).addEventListener(
      'submit.solicitude',
      this.submit.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'validate.cif',
      this.validateCif.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'verify.duplicate',
      this.verifyDuplicated.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'search.companies',
      this.searchCompanies.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'fill.company',
      this.fillCompany.bind(this)
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
      'status.email',
      this.setValidEmail.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'status.phone',
      this.setValidPhone.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'text.change',
      this.setButtonStatus.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'edit.solicitude',
      this.update.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'discard.animation',
      this.discardAnimation.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'movecard.animation',
      this.moveCardAnimation.bind(this)
    )
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
  }

  isCifEmpty(){
    return this.data.values.companyCif == ""
  }

  validateCif(){
    let validationCif = new ValidationCif()
    if(this.isCifEmpty()) {
      this.data.isValidCif = true
      return
    }
    this.data.isValidCif = validationCif.validate(this.data.values.companyCif)
  }

  verifyDuplicated() {
    let validationCif = new ValidationCif()
    let validation = validationCif.validate(this.data.values.companyCif)
    if(validation){
      let cif = this.data.values.companyCif
      Bus.publish('verify.company.duplicate', cif)
    }
  }

  searchCompanies(event){
    this.data.suggestedCompanies = []
    if(this.hasRequiredLength()){
      Bus.publish('search.company.matches', event.detail)
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

    validateContact(){
      this.data.isValidContact = this.validEmail || this.validPhonenumber
    }

    setButtonStatus(){
      this.data.submittable = false
      if (!this.textIsEmpty() && this.data.isValidContact && this.data.isValidCompanyIdentity) {
        this.data.submittable = true
      }
    }

    setValidEmail(event){
      this.validEmail = event.detail.valid
      this.validateContact()
    }

    setValidPhone(event){
      this.validPhonenumber = event.detail.valid
      this.validateContact()
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
        "companyName": "",
        "companyCif": "",
        "companyEmployees": "",
        "companyCnae": "",
        "suggestions" : ""
      },
      suggestedCompanies: [],
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
      }
    }
  }
}
