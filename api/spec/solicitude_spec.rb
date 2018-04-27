require 'net/http'
require 'rspec'
require 'json'
require 'rack/test'
require "date"

require_relative '../fixtures/fixtures'
require_relative './page_object/solicitudes'

describe 'Solicitude Api' do

  include Rack::Test::Methods

  def app
    Fixtures
  end

  context 'create solicitude' do
    before(:each) do
      post 'fixtures/clean'
    end

    it 'returns the brand new solicitude' do
      body = {
        "name": Fixtures::NAME,
        "surname": Fixtures::SURNAME,
        "email": Fixtures::EMAIL,
        "phonenumber": Fixtures::PHONENUMBER,
        "text" => Fixtures::TEXT,
        "date" => Fixtures::DATE
      }.to_json

      post_create_solicitude(body)

      created_solicitude = JSON.parse(last_response.body)
      expect(created_solicitude["name"]).to eq(Fixtures::NAME)
      expect(created_solicitude["surname"]).to eq(Fixtures::SURNAME)
      expect(created_solicitude["email"]).to eq(Fixtures::EMAIL)
      expect(created_solicitude["phonenumber"]).to eq(Fixtures::PHONENUMBER)
      expect(created_solicitude["text"]).to eq(Fixtures::TEXT)
      expect(created_solicitude["date"]).to eq(Fixtures::DATE)
      expect(created_solicitude["creation_moment"]).not_to be_nil
    end
  end

  context 'retrieve solicitude' do
    before(:each) do
      post '/fixtures/pristine'
    end

    it 'returns all solicitudes' do

      post '/api/retrieve-solicitudes'

      response = JSON.parse(last_response.body)
      expect(response['data'].count).to eq(Fixtures::SOLICITUDES_COUNT)
    end
  end

  context 'retrieve solicitude' do
    before(:each) do
      post '/fixtures/pristine'
    end

    it 'returns one solicitude' do

      post '/api/retrieve-solicitude', { 'id' => Fixtures::CREATION_MOMENT }.to_json

      response = JSON.parse(last_response.body)
      expect(response['data']['creation_moment']).to eq(Fixtures::CREATION_MOMENT)
    end
  end
end
