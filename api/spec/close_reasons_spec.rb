require 'json'
require 'rack/test'

require_relative './fixtures/asesora_with_fixtures'


describe 'Reasons for close' do

  include Rack::Test::Methods

  def app
    AsesoraWithFixtures
  end

  it 'retrieves complete catalog' do
    post '/api/close-reasons', {}
    catalog = JSON.parse(last_response.body)

    expect(catalog['data'].size).to be 5
  end
end
