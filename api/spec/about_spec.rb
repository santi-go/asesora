require 'net/http'
require 'rspec'
require 'json'
require 'rack/test'

require_relative './fixtures/asesora_with_fixtures'

describe 'About Api' do

  include Rack::Test::Methods

  def app
    AsesoraWithFixtures
  end

  context 'retieves the about information' do
    it 'returns all' do
      post '/api/about'

      retrieved_information = JSON.parse(last_response.body)

      expect(retrieved_information['name']).to_not be_nil
      expect(retrieved_information['description']).to_not be_nil
      expect(retrieved_information['version']).to_not be_nil
    end
  end
end
