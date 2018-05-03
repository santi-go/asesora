import SolicitudesEditionView from '../views/solicitude/asesora-solicitudes-edition'
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
    window.addEventListener("beforeunload", this.leaving.bind(this))
  }

  hasChanges(){
    for(let key in this.data.values){
      if (this.data.values[key] != this.initialValues[key]) return true
    }
    return false
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
      this.$on('moveCard', function(){
        let element = this.$el
        window.setTimeout(function(){
          element.style.marginTop = '-1000px'
          window.setTimeout(function(){
            window.location = "/solicitudes-list.html"
          }, 1000)
        }, 1000)
      }.bind(this)),

      this.$on('moveErrorCard', function(){
        let element = this.$el
        window.setTimeout(function(){
          element.style.marginTop = '-1000px'
          window.setTimeout(function(){
            location.reload()
          }, 1000)
        }, 1000)
      }.bind(this)),

      this.$on('discardCard', function(){
        this.$data.showAlert = false
        let element = this.$el
        window.setTimeout(function(){
          element.style.marginTop = '1000px'
          window.setTimeout(function(){
            window.location = "/solicitudes-list.html"
          }, 1000)
        }, 1000)
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
      editionmode: true,
      showAlert: true,
      fullfilled: false,
      errors: false,
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
