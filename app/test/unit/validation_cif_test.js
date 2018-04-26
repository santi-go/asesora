const expect = require('chai').expect

import ValidationCif from '../../src/js/services/validation-cif'

describe('Validation Service', () => {
  it('of CIF/CIF', ()=> {
    let list = ["A01316637", "B91735456", "B41745100", "B63765754", "B63964506", "B91874164", "G23536238", "G31947351", "B97539795", "B74267485", "F93020618", "23801250E", "39727019q", "Y2612493Y", "X4945396M", "06033994J", "00820673X"]
    let result = ""
    let validationCif = new ValidationCif()

    list.forEach(function(value) {
      result = validationCif.validate(value)
      expect(result).to.be.true
    })
  })

  it('of erroneous CIF/NIF', ()=> {
    let list = ["A0131X637", "B9735456", "41745100", "z63765754", "Y63964506", "B61874164", "G2338", "23800250E", "39727019X", "Z2612493Y"]
    let result = ""
    let validationCif = new ValidationCif()

    list.forEach(function(value) {
      result = validationCif.validate(value)
      expect(result).to.be.false
    })
  })

})
