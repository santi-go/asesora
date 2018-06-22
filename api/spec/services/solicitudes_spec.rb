require 'json'

require_relative  '../../system/services/solicitudes/service'
require_relative  '../../system/domain/solicitude'
require_relative './../fixtures/fixtures'

describe 'Solicitude service' do
  include Rack::Test::Methods

  def app
    Fixtures
  end

  after(:each) do
    post 'fixtures/clean'
  end

  it 'knows when company hasnt solicitudes' do
    post 'fixtures/clean'

    result = Solicitudes::Service.times_company("non_existing_cif")

    expect(result).to eq(0)
  end

  it 'knows how many solicitudes has one company' do
    post 'fixtures/pristine'

    result = Solicitudes::Service.times_company(Fixtures::COMPANY_CIF)

    expect(result).to eq(Fixtures::SOLICITUDES_COUNT_FOR_DEFAULT_COMPANY)
  end

  it 'update edition moment', :wip do
      date = Fixtures::DATE
      text = Fixtures::TEXT
      applicant = '1'
      company = '12345678Z'

      solicitude = Solicitudes::Service.create(date, text, applicant, company)
      creation_moment = solicitude['creation_moment']
      first_solicitude = Solicitudes::Service.retrieve(creation_moment)
      sleep 1
      solicitude_update = Solicitudes::Service.update(date, text, applicant, company, creation_moment)
      second_solicitude = Solicitudes::Service.retrieve(creation_moment)

      first_solicitude['edition_moment']
      second_solicitude['edition_moment']
      expect(first_solicitude['edition_moment']).not_to eq(second_solicitude['edition_moment'])
  end
end
