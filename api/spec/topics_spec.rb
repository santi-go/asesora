require 'json'
require 'rack/test'

require_relative './fixtures/fixtures'


describe 'Topics' do

  include Rack::Test::Methods

  def app
    Fixtures
  end

  it 'retrieves complete catalog' do
    post '/api/topics', {}
    catalog = JSON.parse(last_response.body)

    expect(catalog['data'].size).to be 69
  end
end
