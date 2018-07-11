import { mount } from '@vue/test-utils'
import SubjectsList from '../../src/js/views/solicitude/subjects/asesora-subjects-list.vue'

describe('SubjectsList', () => {
  it('add class when subject closed', () => {
    const subjects = [
      {
        closing_moment: null
      },
      {
        closing_moment: 'a_moment'
      }
    ]

    const component = mount(SubjectsList, {
      propsData: {
        labels: {},
        values: {
          subjects: subjects
        }
      }
    })

    const closedSubject = component.findAll('.closedSubject')

    expect(closedSubject.length).to.eq(1)
  })

})
