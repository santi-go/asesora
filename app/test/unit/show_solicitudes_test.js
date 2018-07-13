import { mount } from '@vue/test-utils'
import ShowSolicitudes from '../../src/js/views/solicitude/asesora-show-solicitude.vue'

let labels = {
  comments: "Default Label Comments"
}

let subject = {
  id: 1,
  proposal: [],
  description: "Default Description",
  topics: [],
  analysis: "Default Analysis",
  comments: "Default Comments"
}

describe('Show solicitudes', () => {
  it('renders subject list', () => {
    let analysis = 'An analysis'
    subject.analysis = analysis

    const component = mount(ShowSolicitudes, {
      propsData: {
        labels: labels,
        values: {
          applicantCcaa: {},
          subjects: [
            subject
          ]
        }
      }
    })

    expect(component.text()).to.contain(analysis)
  })

  it('renders a comment in subject list', () => {
    let comments = 'A text in comment'
    subject.comments = comments

    const component = mount(ShowSolicitudes, {
      propsData: {
        labels: labels,
        values: {
          applicantCcaa: {},
          subjects: [
            subject
          ]
        }
      }
    })

    expect(component.text()).to.contain(comments)
  })


  it('not render label if not exist a subject comments in subject list', () => {
    let labelComments = 'Label de comentarios'
    subject.comments = ''
    labels.comments = labelComments

    const component = mount(ShowSolicitudes, {
      propsData: {
        labels: labels,
        values: {
          applicantCcaa: {},
          subjects: [
            subject
          ]
        }
      }
    })

    expect(component.text()).not.to.contain(labelComments)
  })

})
