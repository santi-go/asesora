import { mount } from '@vue/test-utils'
import SolicitudesList from '../../src/js/views/solicitude/asesora-solicitudes-list.vue'

describe('SolicitudesList', () => {
  it('renders applicant fullname', () => {
    const solicitudes = [
      {
        name: 'ApplicantName',
        surname: 'ApplicantSurname'
      }
    ]

    const component = mount(SolicitudesList, {
      propsData: {
        labels: {},
        solicitudes: solicitudes
      }
    })

    expect(component.text()).to.includes('ApplicantName ApplicantSurname')
  })

  it('renders applicant name when surname is not available', () => {
    const solicitudes = [
      {
        name: 'ApplicantName',
        surname: ''
      }
    ]

    const component = mount(SolicitudesList, {
      propsData: {
        labels: {},
        solicitudes: solicitudes
      }
    })
    expect(component.text()).to.includes('ApplicantName')
  })

  it('renders notApply label when applicant is not provided', () => {
    const notApplyLabel = 'n/a'
    const solicitudes = [
      {
        name: '',
        surname: ''
      }
    ]

    const component = mount(SolicitudesList, {
      propsData: {
        labels: {
          notApply: notApplyLabel
        },
        solicitudes: solicitudes
      }
    })

    expect(component.text()).to.contain(notApplyLabel)
  })
})
