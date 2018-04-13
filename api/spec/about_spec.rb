require 'net/http'
require 'rspec'
require 'json'
require 'rack/test'

require_relative '../asesora.rb'

describe 'About Api' do

  include Rack::Test::Methods

  def app
    Asesora
  end

  context 'retieves the application' do
    it 'about information' do
      basic_information = {
        "name" => 'Asesora',
        "description" => 'description',
        "version" => '0.0.1'
      }

      post '/api/about'

      retrieved_information = JSON.parse(last_response.body)
      expect(retrieved_information).to eq(basic_information)
    end
  end
end
