require 'json'
require 'rack/test'

describe 'Cnae' do

  include Rack::Test::Methods

  def app
    Asesora
  end

  it 'retrieves complete catalog' do
    post '/api/cnae', {}
    catalog = JSON.parse(last_response.body)

    expect(catalog['data'].size).to be 346
  end
end
