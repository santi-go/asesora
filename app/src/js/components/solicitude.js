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
    Bus.subscribe("got.solicitude", this.updateModel.bind(this))
    Bus.subscribe("got.applicant.matches", this.populateSuggestedApplicants.bind(this))
    Bus.subscribe("updated.company", this.updatedCompany.bind(this))
    Bus.subscribe("got.company.count", this.gotCompanyCount.bind(this))
  }

  watchActions(){
    document.getElementById(this.element).addEventListener(
      'submit.solicitude',
      this.submit.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'changed.company.name',
      this.changedCompanyName.bind(this)
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
      this.changedApplicantField.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'clicked.edit.company',
      this.enableCompanyFields.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'clicked.save.company',
      this.saveCompanyInfo.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'clicked.discard.company.button',
      this.discardCompanyInfo.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'changed.company.employees',
      this.toggleSaveCompanyButton.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'changed.company.cnae',
      this.changedCompanyCnae.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'changed.company.cif',
      this.changedCompanyCif.bind(this)
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
      this.data.editCompany = false
    } else {
      this.data.editionmode = true
      this.data.editCompany = true
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

  toggleSaveCompanyButton(){
    if(this.isCifEmpty() && this.isNameEmpty()){
      this.data.saveCompany = false
    } else if(this.checkForChangesInCompany() && this.data.isValidCompanyIdentity){
      this.data.saveCompany = true
    } else {
      this.data.saveCompany = false
    }
  }

  enableCompanyFields(){
    this.data.editCompany = false
    this.data.disabledTextAndDate = true
  }

  checkForChangesInCompany() {
      if (this.data.values.companyName != this.initialValues.companyName) return true
      if (this.data.values.companyCif != this.initialValues.companyCif) return true
      if (this.data.values.companyEmployees != this.initialValues.companyEmployees) return true
      if (this.data.values.companyCnae != this.initialValues.companyCnae) return true
      return false
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
    Bus.publish('update.applicant', this.data.values )
  }

  saveCompanyInfo(event){
    Bus.publish('update.company', event.detail)
    this.initialValues['companyName'] = this.data.values['companyName']
    this.initialValues['companyEmployees'] = this.data.values['companyEmployees']
    this.initialValues['companyCnae'] = this.data.values['companyCnae']

    this.data.saveCompany = false
    this.data.suggestedCompanies = []
  }

  discardCompanyInfo(){
    this.data.values.companyName = this.initialValues['companyName']
    this.data.values.companyCif = this.initialValues['companyCif']
    this.data.values.companyEmployees = this.initialValues['companyEmployees']
    this.data.values.companyCnae = this.initialValues['companyCnae']

    this.data.editCompany = true
    this.data.isValidCompanyIdentity = true
    this.data.isValidCif = true
    this.data.suggestedCompanies = []
  }

  gotCompanyCount(count){
    if(count.data <= 1) {
      this.data.editCompany = false
    }
  }

  updatedSolicitude(response){
    this.data.showAlert = false
    if (Object.keys(response).length === 0){
      this.data.errors = true
    }else{
      this.data.fullfilled = true
    }
  }
  updatedCompany(){
    this.data.editCompany = true
  }

  updateModel(payload) {
     let dictionary = this.dictionaryOfSolicitude(payload)
     for (let [labelKey, valueKey] of Object.entries(dictionary)) {
       this.data.setValues(labelKey, valueKey)
     }
     this.initialValues = this.data.cloneValues()
     Bus.publish('get.company.count', payload.data.company_cif)
   }

   dictionaryOfSolicitude(payload){
     return {
         'text':  payload.data.text,
         'date':  payload.data.date,
         'applicantId':  payload.data.applicant,
         'applicantName':  payload.data.applicant_name,
         'applicantSurname':  payload.data.applicant_surname,
         'applicantEmail':  payload.data.applicant_email,
         'applicantPhonenumber':  payload.data.applicant_phonenumber,
         'creation_moment': payload.data.creation_moment,
         'companyName': payload.data.company_name,
         'companyCif': payload.data.company_cif,
         'companyEmployees': payload.data.company_employees,
         'companyCnae': payload.data.company_cnae
         }
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

  changedCompanyName(event){
    this.searchCompanies(event)
    this.toggleCompanyIdentityMessage()
    this.toggleSaveCompanyButton()
  }

  changedCompanyCnae(event){
    this.searchCompanies(event)
    this.toggleSaveCompanyButton()
  }

  changedCompanyCif(event){
    this.ensureCif()
    this.toggleCompanyIdentityMessage()
    this.toggleSaveCompanyButton()

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

    this.data.isValidCif = true
    this.data.isValidCompanyIdentity = true
  }

  fillApplicant(item){
    this.data.setValues('applicantName', item.detail.name)
    this.data.setValues('applicantSurname', item.detail.surname)
    this.data.setValues('applicantEmail', item.detail.email)
    this.data.setValues('applicantPhonenumber', item.detail.phonenumber)
    this.data.setValues('applicantId', item.detail.id)

    this.runValidations()
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
      this.data.submittable = true
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
      if (!this.textIsEmpty() && this.isValidContact() && this.data.isValidCompanyIdentity) {
        this.data.submittable = true
      }
    }

    isValidContact(){
      return this.validateEmail() || this.validatePhonenumber()
      }

    validateContact(){
      this.data.isValidContact = this.validEmail || this.validPhonenumber
      this.setButtonStatus()
    }

    runValidations(){
      this.validEmail = this.validateEmail()
      this.validPhonenumber = this.validatePhonenumber()
      
      this.validateContact()
    }

    validateEmail(){
      const email = this.data.values.applicantEmail
      if (email == "") { return false }

      const EMAIL_PATTERN = /^[_a-z0-9-]+(.[_a-z0-9-]+)*@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})$/
      return EMAIL_PATTERN.test(email)
    }

    validatePhonenumber(){
      const phone = this.data.values.applicantPhonenumber
      if (phone == "") { return false }
      return (phone.length == 9)
    }

    setValidEmail(event){
      this.validEmail = event.detail.valid
      this.validateContact()
      this.data.isValidEmail = this.validateEmail()
      if (this.data.values.applicantEmail == "") {
        this.data.isValidEmail = true
      }
    }

    setValidPhone(event){
      this.validPhonenumber = event.detail.valid
      this.validateContact()
      this.data.isValidPhone = this.validatePhonenumber()
      if (this.data.values.applicantPhonenumber == "") {
        this.data.isValidPhone = true
      }
    }

    changedApplicantField(){
      this.setButtonStatus()
      this.searchForApplicants()
    }

    searchForApplicants(){
      this.data.suggestedApplicants = []
      let criteria = {
        'applicantName': this.data.values.applicantName,
        'applicantSurname': this.data.values.applicantSurname,
        'applicantPhonenumber': this.data.values.applicantPhonenumber,
        'applicantEmail': this.data.values.applicantEmail
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
        "applicantEmail": "XXX",
        "applicantPhonenumber": "XXXXXXXXX",
        "applicantName": "XXXX",
        "applicantSurname": "XXXXXXXXX",
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
        "editCompany":"xxxxxxxxxxx",
        "editingCompany": "xxxxxxxxxxxxxx",
        "submitting" : "xxxxxxxxxx",
        "editiondiscard" : "xxxxxxxxxx",
        "editionsubmit" : "xxxxxx",
        "editionsubmitting" : "xxxxxx",
        "errorPhone": "xxxxxxxx",
        "errorEmail": "xxxxxxx",
        "sent" : "XXXX"},
        values: { "text": "",
        "date": "",
        "applicantName": "",
        "applicantSurname": "",
        "applicantEmail": "",
        "applicantPhonenumber": "",
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
      editCompany: false,
      saveCompany: false,
      disabledTextAndDate: false,
      isValidPhone: true,
      isValidEmail: true,
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
