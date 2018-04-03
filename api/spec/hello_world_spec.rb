require 'net/http'
require 'rspec'
require 'json'
require 'rack/test'


require_relative '../asesora.rb'


describe 'Salutation Api' do

  include Rack::Test::Methods

  def app
    Asesora
  end

  describe 'when given a name return a salutation' do
    EXAMPLE_NAME = 'anonymous'

    before(:each) do
      @example = retrieve_example
    end

    it 'greets the rigth person' do
      expect(@example).to eq "hello, " + EXAMPLE_NAME
    end



    def ask_example
      { 'name': EXAMPLE_NAME }.to_json
    end

    def retrieve_example
      post '/api/greet', ask_example
      JSON.parse(last_response.body)
    end
  end
end
