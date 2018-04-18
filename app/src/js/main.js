import Translations from './services/translations'
import Information from './services/information'
import Solicitudes from './services/solicitudes'

import About from './components/about'
import Sidebar from './components/sidebar'
import Solicitude from './components/solicitude'
import SolicitudesList from './components/solicitudes-list'

new Translations()
new Information()
new Solicitudes()

new About()
new Sidebar()

module.exports = {
  Solicitude: Solicitude,
  SolicitudesList: SolicitudesList
};

