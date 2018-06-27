require 'json'
require 'rack/test'

require_relative './fixtures/asesora_with_fixtures'


describe 'Proposals' do

  include Rack::Test::Methods

  def app
    AsesoraWithFixtures
  end

  it 'retrieves complete catalog' do
    post '/api/proposals', {}
    catalog = JSON.parse(last_response.body)

    expect(catalog['data'].size).to be 3
  end
end
