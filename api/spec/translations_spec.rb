require 'net/http'
require 'rspec'
require 'json'
require 'rack/test'

require_relative '../asesora.rb'

describe 'Translations Api' do

  include Rack::Test::Methods

  def app
    Asesora
  end

  context 'allows extract' do
    it 'locale language' do
      body = {
        "locale" => "es"
      }.to_json

      post '/api/translations', body

      retrieved_dictionary = JSON.parse(last_response.body)
      expect(retrieved_dictionary["data"]).not_to be_nil
    end
  end
end
