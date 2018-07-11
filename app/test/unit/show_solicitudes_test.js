import { mount } from '@vue/test-utils'
import ShowSolicitudes from '../../src/js/views/solicitude/asesora-show-solicitude.vue'

describe('Show solicitudes', () => {
  it('renders subject list', () => {
    const subject = {id: 1, proposal: [], topics: [], analysis: "An analysis"}

    const component = mount(ShowSolicitudes, {
      propsData: {
        labels: {},
        values: {
          applicantCcaa: {},
          subjects: [
            subject
          ]
        }
      }
    })

    expect(component.text()).to.contain('An analysis')
  })
})
