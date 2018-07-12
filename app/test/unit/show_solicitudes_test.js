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
  }),

  it('renders a comment in subject list', () => {
    const subject = {id: 1, proposal: [], topics: [], analysis: "An analysis",
                     comments: "A text in comment"}

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

    expect(component.text()).to.contain('A text in comment')
  })
,

  it('not render label if not exist a comment in subject list', () => {
    const subject = {id: 1, proposal: [], topics: [], analysis: "An analysis"}

    const component = mount(ShowSolicitudes, {
      propsData: {
        labels: {
          comments: "Label de comentarios"
        },
        values: {
          applicantCcaa: {},
          subjects: [
            subject
          ]
        }
      }
    })

    expect(component.text()).not.to.contain('Label de comentarios')
  })

})
