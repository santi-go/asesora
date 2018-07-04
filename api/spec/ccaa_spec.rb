require 'json'
require 'rack/test'

require_relative './fixtures/asesora_with_fixtures'


describe 'CCAA' do

  include Rack::Test::Methods

  def app
    AsesoraWithFixtures
  end

  it 'retrieves complete catalog' do
    post '/api/ccaa', {}
    catalog = JSON.parse(last_response.body)

    expect(catalog['data'].size).to be 19
  end
end
