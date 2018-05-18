require 'json'
require 'rack/test'

require_relative './fixtures/fixtures'


describe 'Cnae' do

  include Rack::Test::Methods

  def app
    Fixtures
  end

  it 'retrieves complete catalog' do
    post '/api/cnae', {}
    catalog = JSON.parse(last_response.body)

    expect(catalog['data'].size).to be 346
  end
end
