const expect = require('chai').expect
const sinon = require('sinon')

import {Bus} from '../../src/js/bus'
import {APIClient} from '../../src/js/infrastructure/api_client'
import Translations from '../../src/js/services/translations'

describe('Translations Service', () => {
  context('when has the translation', () => {
    beforeEach(function() {
      const api_response = { data: {'any.label': 'the translation' }}
      this.hit = sinon.stub(APIClient, 'hit').returns(api_response)
    });

    afterEach(function() {
      APIClient.hit.restore();
    });

    it('sends translation', ()=> {
      const element = 'any.element'
      Bus.subscribe('got.translation.for.' + element, (payload) => {
        expect(payload['label']).to.eq('the translation')
      })

      new Translations()

      const data = { key: element, for: 'any.label' }
      Bus.publish('ask.translation', )
    })
  })

  context('when hasnt the translation', () => {
    beforeEach(function() {
      const api_response = { data: {}}
      this.hit = sinon.stub(APIClient, 'hit').returns(api_response)
    });

    afterEach(function() {
      APIClient.hit.restore();
    });

    it('sends asked key', ()=> {
      const label = 'any.label'
      const element = 'any.element'
      Bus.subscribe('got.translation.for.' + element, (payload) => {
        expect(payload['label']).to.eq(label)
      })

      new Translations()

      const data = { key: element, for: label }
      Bus.publish('ask.translation', )
    })
  })
})
