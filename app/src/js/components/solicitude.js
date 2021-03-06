import SolicitudeView from '../views/solicitude/asesora-solicitude'
import {ValidationCif} from '../library/validation-cif'
import {SolicitudeModel} from '../models/solicitude'
import Component from '../infrastructure/component'
import {Bus} from '../bus'
import {APIClient} from '../infrastructure/api_client'

export default class Solicitude extends Component {

  constructor(){
    super('solicitude')
    this.validationCif = ValidationCif
    this.client = APIClient
    this.initialValues = this.data.cloneValues()
    this.validateContact()
    this.load()
  }

  subscribe(){
    Bus.subscribe("got.translation.for.solicitude", this.translate.bind(this))
    Bus.subscribe("created.solicitude", this.createdSolicitude.bind(this))
    Bus.subscribe("created.solicitude.to.add.subject", this.createdSolicitudeToAddSubject.bind(this))
    Bus.subscribe("updated.solicitude", this.updatedSolicitude.bind(this))
    Bus.subscribe("updated.solicitude.and.add.subject", this.updatedSolicitudeAndAddSubject.bind(this))
    Bus.subscribe("deleted.solicitude", this.deletedSolicitude.bind(this))
    Bus.subscribe("deleted.subject", this.deletedSubject.bind(this))
    Bus.subscribe("got.cnae-catalog", this.gotCnaeCatalog.bind(this))
    Bus.subscribe("verified.company.duplicate", this.showDuplicate.bind(this))
    Bus.subscribe("got.company-matches", this.populateSuggestedCompanies.bind(this))
    Bus.subscribe("got.solicitude", this.updateModel.bind(this))
    Bus.subscribe("got.applicant.matches", this.populateSuggestedApplicants.bind(this))
    Bus.subscribe("updated.company", this.updatedCompany.bind(this))
    Bus.subscribe("got.company.count", this.gotCompanyCount.bind(this))
    Bus.subscribe("got.topics-catalog", this.gotTopicsCatalog.bind(this))
    Bus.subscribe("got.ccaa-catalog", this.gotCcaaCatalog.bind(this))
    Bus.subscribe("got.proposals-catalog", this.gotProposalsCatalog.bind(this))
    Bus.subscribe("subject.updated", this.subjectUpdated.bind(this))
    Bus.subscribe("subject.closed", this.subjectClosed.bind(this))
    Bus.subscribe("got.reasons-catalog", this.gotReasonsCatalog.bind(this))
    Bus.subscribe("got.source-formats-catalog", this.gotSourceFormatsCatalog.bind(this))
  }

  watchActions() {
    this.reactTo('submit.solicitude', this.submit.bind(this))
    this.reactTo('submit.solicitude.and.add.subject', this.submitSolicitudeToAddSubject.bind(this))
    this.reactTo('changed.company.name', this.changedCompanyName.bind(this))
    this.reactTo('clicked.company', this.fillCompany.bind(this))
    this.reactTo('clicked.applicant', this.fillApplicant.bind(this))
    this.reactTo('check.submittable', this.setButtonStatus.bind(this))
    this.reactTo('changed.email', this.runValidations.bind(this))
    this.reactTo('changed.ccaa', this.changedApplicantField.bind(this))
    this.reactTo('changed.ccaa', this.warningRequired.bind(this))
    this.reactTo('changed.phone', this.runValidations.bind(this))
    this.reactTo('changed.email', this.setValidEmail.bind(this))
    this.reactTo('changed.phone', this.setValidPhone.bind(this))
    this.reactTo('changed.text', this.setButtonStatus.bind(this))
    this.reactTo('changed.date', this.warningRequired.bind(this))
    this.reactTo('changed.source', this.setButtonStatus.bind(this))
    this.reactTo('changed.source', this.warningRequired.bind(this))
    this.reactTo('edit.solicitude', this.update.bind(this))
    this.reactTo('edit.solicitude.and.add.subject', this.updateAndAddSubject.bind(this))
    this.reactTo('clicked.discard.button', this.discardAnimation.bind(this))
    this.reactTo('fullfilled.solicitude', this.transitToList.bind(this))
    this.reactTo('fullfilled.solicitude.to.add.subject', this.transitToAddSubject.bind(this))
    this.reactTo('changed.applicant.fields', this.changedApplicantField.bind(this))
    this.reactTo('clicked.edit.company', this.enableCompanyFields.bind(this))
    this.reactTo('clicked.save.company', this.saveCompanyInfo.bind(this))
    this.reactTo('clicked.discard.company.button', this.discardCompanyInfo.bind(this))
    this.reactTo('changed.company.employees', this.changedCompanyEmployees.bind(this))
    this.reactTo('changed.company.employees', this.toggleSaveCompanyButton.bind(this))
    this.reactTo('changed.company.employees', this.warningRequired.bind(this))
    this.reactTo('changed.company.cnae', this.changedCompanyCnae.bind(this))
    this.reactTo('changed.company.cnae', this.warningRequired.bind(this))
    this.reactTo('changed.company.cif', this.changedCompanyCif.bind(this))
    this.reactTo('clicked.delete.solicitude', this.deleteSolicitude.bind(this))
    this.reactTo('clicked.add.value.employees.to.company', this.addEmployeesValueToCompany.bind(this))
    this.reactTo('clicked.add.value.name.to.company', this.addNameValueToCompany.bind(this))
    this.reactTo('clicked.add.subject', this.addSubject.bind(this))
    this.reactTo('clicked.subject.list', this.editSubject.bind(this))
    this.reactTo('changed.subject', this.setModifySubjectButtonStatus.bind(this))
    this.reactTo('changed.subject', this.warningSubjectRequired.bind(this))
    this.reactTo('clicked.modify.counseling', this.modifyCounseling.bind(this))
    this.reactTo('clicked.close.counseling', this.closeCounseling.bind(this))
    this.reactTo('clicked.delete.subject', this.deleteSubject.bind(this))

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
      this.data.isValidContact = true
      this.data.editCompany = true
      this.data.values.id = id
      Bus.publish('get.solicitude', {id: id})
    }
    this.warningRequired()
    this.warningSubjectRequired()
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

  addSubject(event){
    window.location.href = "/subjects.html?id=" + event.detail + "=edit"
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

  editSubject(event){
    let reason = event.detail.reason
    if (event.detail.reason == null){
      reason = this.data.reasonsCatalog[0]
      }


    this.data.editionSubject = event.detail.id
    let valuesProposals = []
    for (const proposal of event.detail.proposal) {
      valuesProposals.push({ value: proposal, text: proposal })
    }

    let valuesTopics = []
    for (const topic of event.detail.topics) {
      valuesTopics.push({ value: topic, text: topic.name })
    }

    this.data.setValues('proposals', valuesProposals)
    this.data.setValues('description', event.detail.description)
    this.data.setValues('analysis', event.detail.analysis)
    this.data.setValues('subjectId', event.detail.id)
    this.data.setValues('selectedTopics', valuesTopics)
    this.data.setValues('reason', reason)
    this.data.setValues('comments', event.detail.comments)
    this.data.setValues('closed', event.detail.closed)

    this.warningSubjectRequired()
  }

  gotTopicsCatalog(payload) {
    let catalog = []
    for (const topic of payload.data) {
      catalog.push({ value: topic, text: topic.name })
    }
    this.data.topicsCatalog = catalog
  }

  gotCcaaCatalog(payload) {
    let catalog = []
    for (const ccaa of payload.data) {
      catalog.push({ value: ccaa.id, text: ccaa.name })
    }
    this.data.ccaaCatalog = catalog
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
  }

  gotSourceFormatsCatalog(payload) {
    let catalog = []
    for (const source of payload.data) {
      catalog.push({ value: source.id, text: source.name })
    }
    this.data.sourceCatalog = catalog
  }

  setModifySubjectButtonStatus(){
    this.data.submittable = false

    let analysis = (this.data.values.analysis != "")
    let topics = (this.data.values.selectedTopics.length > 0)
    if(analysis || topics){
      this.data.submittable = true
    }
  }

  modifyCounseling(payload) {
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
    Bus.publish('update.subject', subject)
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

  subjectUpdated(payload){
    this.data.showAlert = false
    this.refreshModifiedSubject(payload)
    this.data.submittable = false
    this.showSubjectModified()
    this.data.editionSubject = false
  }

  subjectClosed(payload){
    this.data.showAlert = false
    this.refreshModifiedSubject(payload)
    this.data.submittable = false
    this.showSubjectModified()
    this.data.editionSubject = false
  }

  showSubjectModified(){
    this.data.modifiedSubjectId = this.data.editionSubject
  }

  refreshModifiedSubject(updatedSubject){
    for (let subject of this.data.values.subjects){
      if (subject.id == updatedSubject.id){
        subject.proposal = updatedSubject.proposal
        subject.description = updatedSubject.description
        subject.analysis = updatedSubject.analysis
        subject.topics = updatedSubject.topics
        subject.comments = updatedSubject.comments
        subject.reason = updatedSubject.reason
        subject.closed = updatedSubject.closed
      }
    }
  }

  enableCompanyFields(){
    this.data.showUpdatedEmployeesValueMessage =  false
    this.data.showUpdatedNameValueMessage =  false
    this.data.editCompany = false
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

  submitSolicitudeToAddSubject(){
    Bus.publish('create.solicitude.to.add.subject', this.data.values)
  }

  update(){
    Bus.publish('update.solicitude', this.data.values )
    Bus.publish('update.applicant', this.data.values )
  }

  updateAndAddSubject(){
    Bus.publish('update.solicitude.and.add.subject', this.data.values )
    Bus.publish('update.applicant', this.data.values )
  }

  addEmployeesValueToCompany(event){
    this.saveCompanyInfo(event)
    this.data.showUpdatedEmployeesValueMessage = true
  }

  addNameValueToCompany(event){
    this.saveCompanyInfo(event)
    this.data.showUpdatedNameValueMessage = true
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

  deleteSolicitude(payload){
    if (!confirm("¿Estás seguro/a de que quieres eliminar esta solicitud?")){
      return
    }

    Bus.publish('delete.solicitude', payload.detail.solicitudeId)
  }

  deleteSubject(payload){
    if (!confirm("¿Estas seguro/a de que quieres eliminar el caso asociado? Ten en cuenta que esta operación no se puede deshacer")){
      return
    }
    Bus.publish('delete.subject', payload.detail)
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

  updatedSolicitudeAndAddSubject(response){
    this.data.showAlert = false
    if (Object.keys(response).length === 0){
      this.data.errors = true
    }else{
      this.data.fullfilledToAddSubject = true
    }
  }

  deletedSolicitude(){
    this.data.showAlert = false
    let element = document.querySelector('#solicitude')
    element.classList.add('discardCard')
    window.setTimeout(function(){
      window.location = "/solicitudes-list.html"
    }, 1250)
  }

  deletedSubject(payload){
    this.data.showAlert = false
    let id = payload.data.id
    let subjects = this.data.values.subjects
    this.data.values.subjects = subjects.filter(function(subject){
      return subject.id != id
    })
  }

  updatedCompany(){
    this.data.editCompany = true
  }

  updateModel(payload) {
    let dictionarySolicitude = this.dictionaryOfSolicitude(payload)
    this.chargeDictionary(dictionarySolicitude)

     if (payload.data.company != undefined){
       let dictionaryCompany = this.dictionaryOfCompany(payload)
       this.chargeDictionary(dictionaryCompany)
     }

     this.initialValues = this.data.cloneValues()
     Bus.publish('get.company.count', payload.data.company_cif)
   }

   chargeDictionary(dictionary){
     for (let [labelKey, valueKey] of Object.entries(dictionary)) {
       this.data.setValues(labelKey, valueKey)
     }
     this.warningRequired()
   }

   dictionaryOfCompany(payload){
     return {
       'companyName': payload.data.company_name,
       'companyCif': payload.data.company_cif,
       'companyEmployees': payload.data.company_employees,
       'companyCnae': payload.data.company_cnae
     }
   }

   dictionaryOfSolicitude(payload){
     return {
         'text':  payload.data.text,
         'source': payload.data.source,
         'date':  payload.data.date,
         'applicantId':  payload.data.applicant,
         'applicantName':  payload.data.applicant_name,
         'applicantSurname':  payload.data.applicant_surname,
         'applicantEmail':  payload.data.applicant_email,
         'applicantPhonenumber':  payload.data.applicant_phonenumber,
         'applicantCcaa': payload.data.applicant_ccaa,
         'creation_moment': payload.data.creation_moment,
         'subjects': payload.data.subjects
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
    this.updateCompanyCnaeMessageStatus()
    this.toggleSaveCompanyButton()
  }

  changedCompanyCif(event){
    this.ensureCif()
    this.toggleCompanyIdentityMessage()
    this.toggleSaveCompanyButton()
  }

  changedCompanyEmployees(event){
    this.updateCompanyEmployeesMessageStatus()
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
    this.data.submittable = true
    this.data.showEditCompanyButton = true
    this.data.editCompany = true
  }

  fillApplicant(item){
    this.data.setValues('applicantName', item.detail.name)
    this.data.setValues('applicantSurname', item.detail.surname)
    this.data.setValues('applicantEmail', item.detail.email)
    this.data.setValues('applicantPhonenumber', item.detail.phonenumber)
    this.data.setValues('applicantCcaa', item.detail.ccaa)
    this.data.setValues('applicantId', item.detail.id)

    this.runValidations()
  }

  showMessageCompanyName(){
    this.data.isValidCompanyName = false
    if(!this.isNameEmpty()){
      this.data.isValidCompanyName = true
      return true
    }
    return false
  }

  showMessageCompanyIdentity(){
    this.data.isValidCompanyIdentity = false
    if(!this.isCifEmpty() && this.data.isValidCif){
      this.data.isValidCompanyIdentity = true
      return true
    }
    return false
  }

  toggleCompanyIdentityMessage(){
    this.showMessageCompanyName()
    this.showMessageCompanyIdentity()
    if( this.isNameEmpty() && this.isCifEmpty() ){
      this.data.isValidCompanyIdentity = true
      this.data.isValidCompanyName = true
    }
    this.setButtonStatus()
  }

  updateCompanyEmployeesMessageStatus(){
    this.showMessageCompanyName()
    this.showMessageCompanyIdentity()
    if( this.isCompanyFullfilledWithEmployees() ){
      this.data.isValidCompanyIdentity = true
      this.data.isValidCompanyName = true
    }
    if( this.isCompanyEmptyWithoutEmployees() ){
      this.data.isValidCompanyIdentity = true
      this.data.isValidCompanyName = true
    }
    if ( this.isCompanyFullfilledWithoutEmployees() ){
      this.data.isValidCompanyIdentity = true
      this.data.isValidCompanyName = true
    }
    this.setButtonStatus()
  }

  isCompanyEmptyWithoutEmployees(){
    return this.isNameEmpty() && this.isCifEmpty() && !this.hasEmployees()
  }

  isCompanyFullfilledWithEmployees(){
    return !this.isNameEmpty() && !this.isCifEmpty() && this.hasEmployees()
  }

  isCompanyFullfilledWithoutEmployees(){
    return !this.isNameEmpty() && !this.isCifEmpty() && !this.hasEmployees()
  }

  isCompanyEmptyWithoutCnae(){
    return this.isNameEmpty() && this.isCifEmpty() && !this.hasCnae()
  }

  isCompanyFullfilledWithCnae(){
    return !this.isNameEmpty() && !this.isCifEmpty() && this.hasCnae()
  }

  isCompanyFullfilledWithoutCnae(){
    return !this.isNameEmpty() && !this.isCifEmpty() && !this.hasCnae()
  }

  updateCompanyCnaeMessageStatus(){
    this.showMessageCompanyName()
    this.showMessageCompanyIdentity()
    if( this.isCompanyFullfilledWithCnae() ){
      this.data.isValidCompanyIdentity = true
      this.data.isValidCompanyName = true
    }
    if( this.isCompanyEmptyWithoutCnae() ){
      this.data.isValidCompanyIdentity = true
      this.data.isValidCompanyName = true
    }
    if ( this.isCompanyFullfilledWithoutCnae() ){
      this.data.isValidCompanyIdentity = true
      this.data.isValidCompanyName = true
    }
    this.setButtonStatus()
  }

  hasCnae(){
    return this.data.values.companyCnae !== ""
  }

  hasEmployees(){
    return this.data.values.companyEmployees !== ""
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
      this.data.cnaeCatalog = payload.data
    }

    discardAnimation(){
      let url = "/solicitudes-list.html"
      this.data.submittable = true
      this.data.showAlert = false

      this.moveCardAnimation('discardCard')
      this.setTimeToRelocateUrl(url)
    }

    transitToList(){
      let url = "/solicitudes-list.html"
      this.initialValues = this.data.cloneValues()
      this.moveCardAnimation('submitCard')
      this.setTimeToRelocateUrl(url)
    }

    transitToAddSubject(){
      let url = "/subjects.html?id=" + this.data.values.id
      this.initialValues = this.data.cloneValues()
      this.moveCardAnimation('submitCard')
      this.setTimeToRelocateUrl(url)
    }

    moveCardAnimation(cssClass){
      let element = document.querySelector('#solicitude')
      element.classList.add(cssClass)
    }

    setTimeToRelocateUrl(url) {
      window.setTimeout(function(){
        window.location = url
      }, 1250)
    }

    createdSolicitude(){
      this.data.fullfilled = true
    }

    createdSolicitudeToAddSubject(event){
      this.data.values.id = event.creation_moment
      this.data.fullfilledToAddSubject = true
    }

    textIsEmpty(){
      return (this.data.values.text == "")
    }

    isValidCompany(){
      return this.data.isValidCompanyIdentity && this.data.isValidCompanyName
    }

    setButtonStatus(){
      this.data.submittable = false
      if (!this.textIsEmpty() && this.isValidContact() && this.isValidCompany()) {
        this.data.submittable = true
      }
    }

    isValidContact(){
      return this.data.isValidContact
      }

    validateContact(){
      const email = this.data.values.applicantEmail
      const phone = this.data.values.applicantPhonenumber
      this.data.isValidContact = this.validEmail && this.validPhonenumber
      if (this.validEmail && phone == "") {
        this.data.isValidContact = true
      }
      if (this.validPhonenumber && email == "") {
        this.data.isValidContact = true
      }
    }

    runValidations(){
      this.validEmail = this.validateEmail()
      this.validPhonenumber = this.validatePhonenumber()

      this.validateContact()
      this.setButtonStatus()
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
      this.runValidations()
      this.searchForApplicants()
    }

    searchForApplicants(){
      this.data.suggestedApplicants = []
      let criteria = {
        'applicantName': this.data.values.applicantName,
        'applicantSurname': this.data.values.applicantSurname,
        'applicantPhonenumber': this.data.values.applicantPhonenumber,
        'applicantEmail': this.data.values.applicantEmail,
        'applicantCcaa': this.data.values.applicantCcaa
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

    warningRequired(){
      this.data.warning = true

      if(this.data.values.companyEmployees &&
         this.data.values.companyCnae &&
         this.data.values.source.text &&
         this.data.values.applicantCcaa.text &&
         this.data.values.date){

        this.data.warning = false
      }
    }

    warningSubjectRequired(){
      this.data.warningSubject = true
      if(this.data.values.selectedTopics.length > 0 &&
         this.data.values.proposals.length > 0){

        this.data.warningSubject = false
      }
    }

    model() {
      return SolicitudeModel
    }
}
