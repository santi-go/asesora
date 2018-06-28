import Translations from './services/translations'
import Information from './services/information'
import Solicitudes from './services/solicitudes'
import Applicants from './services/applicants'
import Companies from './services/companies'


import About from './components/about'
import Sidebar from './components/sidebar'
import Solicitude from './components/solicitude'
import SolicitudesList from './components/solicitudes-list'
import ShowSolicitude from './components/show-solicitude'
import Subjects from './components/subjects'

new Translations()
new Information()
new Solicitudes()
new Applicants()
new Companies()

new About()
new Sidebar()

module.exports = {
  Solicitude: Solicitude,
  SolicitudesList: SolicitudesList,
  ShowSolicitude: ShowSolicitude,
  Subjects: Subjects
};
