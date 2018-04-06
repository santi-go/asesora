import Translations from './services/translations'
import Information from './services/information'
import {APIClient} from './infrastructure/api_client'

import App from './components/app'

new Translations(APIClient)
new Information(APIClient)
new App('#asesora')
