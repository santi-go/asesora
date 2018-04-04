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

  describe 'About API' do
    it 'retieves the application basic information' do
      basic_information = {
        "name" => 'Asesora',
        "description" => 'Registro de asesoramientos técnicos en salud laboral.',
        "version" => '0.0.1'
      }

      post '/api/about'

      retrieved_information = JSON.parse(last_response.body)
      expect(retrieved_information).to eq(basic_information)
    end
  end
end
