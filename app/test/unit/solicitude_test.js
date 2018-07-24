import { mount } from '@vue/test-utils'
import SourceFormatView from '../../src/js/views/solicitude/asesora-source-format.vue'

describe('SourceFormat', () => {
  it('renders source values', () => {
    const source = {
        value: '1',
        text: 'Telefonico'
      }


    const component = mount(SourceFormatView, {
      propsData: {
        labels: {},
        values: {
          source: source
        }
      }
    })
    
    expect(component.text()).to.eq('Telefonico')
  })
})
