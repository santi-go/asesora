import SolicitudeView from '../views/solicitude/asesora-solicitude'
import ValidationCif from '../library/validation-cif'
import Component from '../infrastructure/component'
import {Bus} from '../bus'

export default class Solicitude extends Component {

  constructor(){
    super('solicitude')
    this.validEmail = false
    this.validPhonenumber = false
  }

  subscribe(){
    Bus.subscribe("translation.for.solicitude", this.translate.bind(this))
    Bus.subscribe("created.solicitude", this.createdSolicitude.bind(this))
    Bus.subscribe("got.cnae-catalog", this.gotCnaeCatalog.bind(this))
    Bus.subscribe("verified.company.duplicate", this.showDuplicate.bind(this))
    Bus.subscribe("got.company-matches", this.populateSuggestedCompanies.bind(this))
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
  }

  submit(){
    Bus.publish('create.solicitude', this.data.values)
  }

  isCifEmpty(){
    return this.data.values.companyCif == ""
  }

  validateCif(){
    let validationCif = new ValidationCif()
    if(this.isCifEmpty()) {
      this.data.validatedcif = true
      return
    }
    this.data.validatedcif = validationCif.validate(this.data.values.companyCif)
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
    this.data.suggestedcompanies = []
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
    this.data.suggestedcompanies = payload.data
  }

  showDuplicate(payload) {
    let duplicatedCompany =[]
    if ( !this.isObjectEmpty(payload) ) {
      duplicatedCompany.push(payload)
    }
    this.data.suggestedcompanies = duplicatedCompany
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

    this.data.validcompanyidentity = false
    if(this.isNameEmpty() && this.isCifEmpty()){
      this.data.validcompanyidentity = true
    }
    if(!this.isNameEmpty() && !this.isCifEmpty() && this.data.validatedcif){
      this.data.validcompanyidentity = true
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
    this.data.cnaecatalog = payload
  }

  initializeViews(){
    let listView = {
      'asesora-solicitude': SolicitudeView
    }

    let mounted =function() {
      let submitAnimationDelay = 1500

      this.$on('moveCard', function(){
        let element = this.$el
        element.classList.add('submitCard')
        window.setTimeout(function(){
          location.reload()
        }, submitAnimationDelay )
      }.bind(this))
    }
    super.initializeViews(listView, mounted)
  }

  createdSolicitude(){
    this.data.fullfilled = true
  }

  textIsEmpty(){
    return (this.data.values.text == "")
  }

  validateContact(){
    this.data.validcontact = this.validEmail || this.validPhonenumber
  }

  setButtonStatus(){
    this.data.submittable = false
    if (!this.textIsEmpty() && this.data.validcontact && this.data.validcompanyidentity) {
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
      editionmode: false,
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
                "submitting" : "xxxxxxxxxx",
                "suggestions" : "xxxxxx",
                "submit" : "xxxxxxxxxx",
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
      suggestedcompanies: [],
      fullfilled: false,
      validatedcif: true,
      cnaecatalog:[],
      validcompanyidentity: true,
      validcontact: true,
      submittable: false,
      translate:function(key,value) {
        this.labels[key] = value
      },
      setValues:function(key, value) {
        this.values[key] = value
      }
    }
  }
}
