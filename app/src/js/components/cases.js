import CasesView from '../views/solicitude/asesora-cases'
import Component from '../infrastructure/component'
import {Bus} from '../bus'
import {APIClient} from '../infrastructure/api_client'

export default class Cases extends Component {

  constructor(){
    super('cases')
    this.client = APIClient
    this.load()
  }

  subscribe(){

  }

  watchActions(){

  }

  initializeViews(){
    let listView = {
      'asesora-cases': CasesView
    }
    let mounted =function() {}
    super.initializeViews(listView, mounted)
  }

  load(){

  }

  model(){
    return {
      labels: {
      },
      values: {
      }

    }
  }
}
