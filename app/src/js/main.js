import Translations from './services/translations'
import Information from './services/information'
import {APIClient} from './infrastructure/api_client'

import About from './components/about'
import Solicitude from './components/solicitude'

new Translations(APIClient)
new Information(APIClient)
new About()
new Solicitude()
