import SolicitudeView from '../views/solicitude/asesora-solicitude'
import ValidationCif from '../library/validation-cif'
import Component from '../infrastructure/component'
import {Bus} from '../bus'

export default class Solicitude extends Component {

  constructor(){
    super('solicitude')
  }

  subscribe(){
    Bus.subscribe("translation.for.solicitude", this.translate.bind(this))
    Bus.subscribe("created.solicitude", this.createdSolicitude.bind(this))
    Bus.subscribe("got.cnae-catalog", this.gotCnaeCatalog.bind(this))
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
    console.log(this.data.cnaecatalog);
  }

  initializeViews(){
    let listView = {
      'asesora-solicitude': SolicitudeView
    }

    let mounted =function() {
        this.$on('moveCard', function(){
          let element = this.$el
          window.setTimeout(function(){
            element.style.marginTop = '-1000px'
            window.setTimeout(function(){
              location.reload()
            }, 1000)
          }, 1000)
        }.bind(this))
      }

    super.initializeViews(listView, mounted)
  }

  createdSolicitude(){
    this.data.fullfilled = true
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
                "companyCnae": ""
              },
      fullfilled: false,
      validatedcif: true,
      cnaecatalog:[],
      translate:function(key,value) {
        this.labels[key] = value
      }
    }
  }
}
