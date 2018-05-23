require 'net/http'
require 'rspec'
require 'json'
require 'rack/test'
require 'date'

require_relative './fixtures/fixtures'

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
        'name'=> Fixtures::NAME,
        'surname'=> Fixtures::SURNAME,
        'email'=> Fixtures::EMAIL,
        'phonenumber'=> Fixtures::PHONENUMBER,
        'text'=> Fixtures::TEXT,
        'date'=> Fixtures::DATE
      }.to_json

      post_create_solicitude(body)

      created_solicitude = JSON.parse(last_response.body)
      
      expect(created_solicitude['applicant']).not_to be_empty
      expect(created_solicitude['text']).to eq(Fixtures::TEXT)
      expect(created_solicitude['date']).to eq(Fixtures::DATE)
      expect(created_solicitude['creation_moment']).not_to be_nil
    end

    it 'generate creation moment in milliseconds' do
      body = {
        'name'=> Fixtures::NAME,
        'surname'=> Fixtures::SURNAME,
        'email'=> Fixtures::EMAIL,
        'phonenumber'=> Fixtures::PHONENUMBER,
        'text' => Fixtures::TEXT,
        'date' => ''
      }.to_json
      previous_moment = DateTime.now.strftime(in_microseconds)
      post_create_solicitude(body)
      later_moment = DateTime.now.strftime(in_microseconds)

      created_solicitude = JSON.parse(last_response.body)

      expect(created_solicitude['creation_moment']).to be_between(previous_moment, later_moment).inclusive

    end

    it 'new solicitude has today date' do
      body = {
        'name'=> Fixtures::NAME,
        'surname'=> Fixtures::SURNAME,
        'email'=> Fixtures::EMAIL,
        'phonenumber'=> Fixtures::PHONENUMBER,
        'text' => Fixtures::TEXT,
        'date' => ''
      }.to_json
      post_create_solicitude(body)
      today = Date.today.strftime(in_english_format)

      created_solicitude = JSON.parse(last_response.body)
      
      expect(created_solicitude['applicant']).not_to be_empty
      expect(created_solicitude['text']).to eq(Fixtures::TEXT)
      expect(created_solicitude['date']).to eq(today)
    end
  end

  context 'retrieve solicitude' do
    before(:each) do
      post 'fixtures/pristine'
    end

    it 'returns all solicitudes' do
      body = {
        'name'=> Fixtures::NAME,
        'surname'=> Fixtures::SURNAME,
        'email'=> Fixtures::EMAIL,
        'phonenumber': Fixtures::PHONENUMBER,
        'text' => Fixtures::TEXT,
        'date' => ''
      }.to_json

      post '/api/retrieve-solicitudes'
      retrieved_information = JSON.parse(last_response.body)
      previous_counter = retrieved_information['data'].count

      post_create_solicitude(body)
      post_create_solicitude(body)

      post '/api/retrieve-solicitudes'
      retrieved_information = JSON.parse(last_response.body)
      actual_counter = retrieved_information['data'].count

      verification = actual_counter >= previous_counter

      expect(actual_counter - previous_counter).to eq(2)
      expect(verification).to eq(true)
    end

    it 'returns solicitudes in descendent order' do
      first_body = {
        'name'=> Fixtures::NAME,
        'surname'=> Fixtures::SURNAME,
        'email'=> Fixtures::EMAIL,
        'phonenumber'=> Fixtures::PHONENUMBER,
        'text' => Fixtures::TEXT,
        'date' => Fixtures::DATE
        }.to_json
      post_create_solicitude(first_body)
      second_body = {
        'name'=> Fixtures::NAME,
        'surname'=> Fixtures::SURNAME,
        'email'=> Fixtures::EMAIL,
        'phonenumber'=> Fixtures::PHONENUMBER,
        'text' => Fixtures::TEXT,
        'date' => Fixtures::DATE
        }.to_json
      post_create_solicitude(second_body)

      post '/api/retrieve-solicitudes'
      response = JSON.parse(last_response.body)
      first_solicitude = retrieve_first_date(response)
      first_creation_moment = retrieve_first_creation_moment(response)
      second_solicitude = retrieve_second_date(response)
      second_creation_moment = retrieve_second_creation_moment(response)

      creation_moment = first_creation_moment > second_creation_moment
      expect(first_solicitude).to eq(Fixtures::DATE)
      expect(second_solicitude).to eq(Fixtures::DATE)
      expect(creation_moment).to eq(true)
    end
  end
  context 'retrieve solicitude' do
    before(:each) do
      post 'fixtures/clean'
    end

    it 'returns one solicitude' do
      body = {
        'name'=> Fixtures::NAME,
        'surname'=> Fixtures::SURNAME,
        'email' => Fixtures::EMAIL,
        'phonenumber'=> Fixtures::PHONENUMBER,
        'text' => Fixtures::TEXT,
        'date' => Fixtures::DATE
      }.to_json

      post_create_solicitude(body)

      created_solicitude = JSON.parse(last_response.body)

      id = {id: created_solicitude['creation_moment']}.to_json

      post '/api/retrieve-solicitude', id

      solicitude = JSON.parse(last_response.body)

      expect(solicitude['data'][Fixtures::TEXT]).to eq(created_solicitude[Fixtures::TEXT])
      expect(solicitude['data'][Fixtures::DATE]).to eq(created_solicitude[Fixtures::DATE])
      expect(solicitude['data'][Fixtures::NAME]).to eq(created_solicitude[Fixtures::NAME])
      expect(solicitude['data'][Fixtures::SURNAME]).to eq(created_solicitude[Fixtures::SURNAME])
      expect(solicitude['data'][Fixtures::EMAIL]).to eq(created_solicitude[Fixtures::EMAIL])
      expect(solicitude['data'][Fixtures::PHONENUMBER]).to eq(created_solicitude[Fixtures::PHONENUMBER])
    end
  end

  context 'of the applicant' do
    before(:each) do
      post 'fixtures/clean'
    end

    it 'search matches by filter' do
      first_body = {
        'name': Fixtures::NAME,
        'surname': Fixtures::SURNAME,
        'email': Fixtures::EMAIL,
        'phonenumber': Fixtures::PHONENUMBER,
        'text' => Fixtures::TEXT,
        'date' => Fixtures::DATE
        }.to_json
      post_create_solicitude(first_body)
      second_body = {
        'name': Fixtures::NAME_2,
        'surname': Fixtures::SURNAME_2,
        'email': Fixtures::EMAIL_2,
        'phonenumber': Fixtures::PHONENUMBER_2,
        'text' => Fixtures::TEXT,
        'date' => Fixtures::DATE
        }.to_json
      post_create_solicitude(second_body)

      matches_body = {
        'name': '',
        'surname': Fixtures::SURNAME_2,
        'email': '',
        'phonenumber': ''
      }.to_json
      post '/api/applicant-matches', matches_body
      response = JSON.parse(last_response.body)
      expect(response['data'][0]['phonenumber']).to eq(Fixtures::PHONENUMBER_2)

      matches_body = {
        'name': Fixtures::NAME,
        'surname': '',
        'email': '',
        'phonenumber': ''
      }.to_json
      post '/api/applicant-matches', matches_body
      response = JSON.parse(last_response.body)
      expect(response['data'].length).to be >= 2
    end
  end
  private

  def in_microseconds
    return '%Q'
  end

  def in_english_format
    return '%Y-%m-%d'
  end

  def post_create_solicitude(body_created)
    post '/api/create-solicitude', body_created
  end

  def retrieve_date(information)
    return information['date']
  end

  def retrieve_first_date(response)
    retrieve_date(response['data'][0])
  end

  def retrieve_second_date(response)
    retrieve_date(response['data'][1])
  end

  def retrieve_creation_moment(information)
    return information['creation_moment']
  end

  def retrieve_first_creation_moment(response)
    retrieve_creation_moment(response['data'][0])
  end

  def retrieve_second_creation_moment(response)
    retrieve_creation_moment(response['data'][1])
  end
end
