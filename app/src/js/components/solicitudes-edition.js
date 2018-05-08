import SolicitudesEditionView from '../views/solicitude/asesora-solicitudes-edition'
import ValidationCif from '../library/validation-cif'
import Component from '../infrastructure/component'
import {Bus} from '../bus'

export default class SolicitudesEdition extends Component{

  constructor(){
    super('solicitudes-edition')
    this.load()
  }

  subscribe(){
    Bus.subscribe('got.solicitude', this.updateModel.bind(this))
    Bus.subscribe("updated.solicitude", this.updatedSolicitude.bind(this))
    Bus.subscribe("translation.for.solicitudes-edition", this.translate.bind(this))
    Bus.subscribe("got.cnae-catalog", this.gotCnaeCatalog.bind(this))
  }

  watchActions(){
    document.getElementById(this.element).addEventListener(
      'load.solicitude',
      this.load.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'edit.solicitude',
      this.update.bind(this)
    )
    document.getElementById(this.element).addEventListener(
      'validate.cif',
      this.validateCif.bind(this)
    )
    window.addEventListener("beforeunload", this.leaving.bind(this))
  }

  hasChanges(){
    for(let key in this.data.values){
      if (this.data.values[key] != this.initialValues[key]) return true
    }
    return false
  }

  validateCif(){
    let validationCif = new ValidationCif()
    if(this.isCifEmpty()) {
      this.data.validatedcif = true
      return
    }
    this.data.validatedcif = validationCif.validate(this.data.values.companyCif)
  }

  isCifEmpty(){
    return this.data.values.companyCif == ""
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

  update(){
    Bus.publish('update.solicitude', this.data.values)
  }

  load(){
    let url = document.URL
    let index = url.indexOf("=")
    let id = url.slice(index + 1)
    Bus.publish('get.solicitude', {id: id})
  }

  translate(payload) {
    let key= payload.key
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

  initializeViews(){
    let listView ={
      'asesora-solicitudes-edition': SolicitudesEditionView
    }

    let mounted = function() {
      let submitAnimationDelay = 1500
      let discardAnimationDelay = 1500

      this.$on('moveCard', function(){
        let element = this.$el
        element.classList.add('submitCard')
        window.setTimeout(function(){
          window.location = "/solicitudes-list.html"
        }, submitAnimationDelay)
      }.bind(this)),

      this.$on('moveErrorCard', function(){
        let element = this.$el
        element.classList.add('discardCard')
        window.setTimeout(function(){
          location.reload()
        }, discardAnimationDelay)
      }.bind(this)),

      this.$on('discardCard', function(){
        this.$data.showAlert = false
        let element = this.$el
        element.classList.add('discardCard')
        window.setTimeout(function(){
          window.location = "/solicitudes-list.html"
        }, discardAnimationDelay)
      }.bind(this))
    }
    super.initializeViews(listView, mounted)
  }

  updatedSolicitude(response){
    this.data.showAlert = false
    if (Object.keys(response).length === 0){
      this.data.errors = true
    }else{
      this.data.fullfilled = true
    }
  }

  model(){
    return {
      validatedcif: true,
      editionmode: true,
      showAlert: true,
      fullfilled: false,
      errors: false,
      cnaecatalog: [],
      labels: { "name": "XXXXX",
                "surname": "XXXXX",
                "email": "XXXXX",
                "phonenumber": "XXXXX",
                "date": "XXXXX",
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
                "submit" : "xxxxxxxxxx",
                "discard" : "xxxxxxx",
                "discarding" : "xxxxxxxxxx",
                "edited" : "xxxxxx",
                "alertBackgroundDanger" : "xxxxxxxxx"
               },
      values: { "text": "",
                "date": "",
                "name": "",
                "surname": "",
                "email": "",
                "phonenumber": "",
                "creation_moment": "",
                "companyName": "",
                "companyCif": "",
                "companyEmployees": "",
                "companyCnae": "" },
      translate:function(key,value) {
        this.labels[key] = value
      },
      setValues:function(key, value){
        this.values[key] = value
      },
      cloneValues:function(){
        let clone = Object.assign({}, this.values)
        return clone
      }
    }
  }
}
