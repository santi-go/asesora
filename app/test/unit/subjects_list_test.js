import { mount } from '@vue/test-utils'
import SubjectsList from '../../src/js/views/solicitude/subjects/asesora-subjects-list.vue'

describe('SubjectsList', () => {
  it('add class when subject closed', () => {
    const subjects = [
      {
        closed: null
      },
      {
        closed: 'a_moment'
      }
    ]

    const component = mount(SubjectsList, {
      propsData: {
        labels: {},
        reasonsCatalog:{},
        values: {
          subjects: subjects,
          selectedTopics: [],
          proposals: []
        }
      }
    })

    const closedSubject = component.findAll('.closedSubject')

    expect(closedSubject.length).to.eq(1)
  })

})
