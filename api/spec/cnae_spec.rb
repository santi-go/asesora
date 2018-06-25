require 'json'
require 'rack/test'

require_relative './fixtures/asesora_with_fixtures'


describe 'Cnae' do

  include Rack::Test::Methods

  def app
    AsesoraWithFixtures
  end

  it 'retrieves complete catalog' do
    post '/api/cnae', {}
    catalog = JSON.parse(last_response.body)

    expect(catalog['data'].size).to be 346
  end
end
