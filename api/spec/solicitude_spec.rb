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
        'applicantName': Fixtures::APPLICANT_NAME,
        'applicantSurname': Fixtures::APPLICANT_SURNAME,
        'applicantEmail': Fixtures::APPLICANT_EMAIL,
        'applicantPhonenumber': Fixtures::APPLICANT_PHONENUMBER,
        'text': Fixtures::TEXT,
        'date': Fixtures::DATE,
        'applicantId': "",
        'companyCif': ""
      }.to_json

      post_create_solicitude(body)

      created_solicitude = JSON.parse(last_response.body)

      expect(created_solicitude['applicant']).not_to be_empty
      expect(created_solicitude['text']).to eq(Fixtures::TEXT)
      expect(created_solicitude['date']).to eq(Fixtures::DATE)
      expect(created_solicitude['creation_moment']).not_to be_nil
    end

    it 'returns the new solicitude with existent applicant id' do
      body = {
        'applicantName': Fixtures::APPLICANT_NAME,
        'applicantSurname': Fixtures::APPLICANT_SURNAME,
        'applicantEmail': Fixtures::APPLICANT_EMAIL,
        'applicantPhonenumber': Fixtures::APPLICANT_PHONENUMBER,
        'text': Fixtures::TEXT,
        'date': Fixtures::DATE,
        'applicantId': "",
        'companyCif': ""
      }.to_json

      post_create_solicitude(body)
      created_solicitude = JSON.parse(last_response.body)
      applicant_id = created_solicitude['applicant']
      expect(applicant_id).not_to be_empty

      body_with_id = {
        'applicantName': Fixtures::APPLICANT_NAME_2,
        'applicantSurname': Fixtures::APPLICANT_SURNAME_2,
        'applicantEmail': Fixtures::APPLICANT_EMAIL_2,
        'applicantPhonenumber': Fixtures::APPLICANT_PHONENUMBER_2,
        'text': Fixtures::TEXT,
        'date': Fixtures::DATE,
        'applicantId': applicant_id,
        'companyCif': ""
      }.to_json

      post_create_solicitude(body_with_id)

      matches_body = {
        'applicantName': '',
        'applicantSurname': Fixtures::APPLICANT_SURNAME_2,
        'applicantEmail': '',
        'applicantPhonenumber': ''
      }.to_json
      post '/api/applicant-matches', matches_body
      response = JSON.parse(last_response.body)
      expect(response['data'].length).to eq(0)
    end

    it 'generate creation moment in milliseconds' do
      body = {
        'applicantName': Fixtures::APPLICANT_NAME,
        'applicantSurname': Fixtures::APPLICANT_SURNAME,
        'applicantEmail': Fixtures::APPLICANT_EMAIL,
        'applicantPhonenumber': Fixtures::APPLICANT_PHONENUMBER,
        'text': Fixtures::TEXT,
        'date': '',
        'applicantId': "",
        'companyCif': ""
      }.to_json
      previous_moment = DateTime.now.strftime(in_microseconds)
      post_create_solicitude(body)
      later_moment = DateTime.now.strftime(in_microseconds)

      created_solicitude = JSON.parse(last_response.body)

      expect(created_solicitude['creation_moment']).to be_between(previous_moment, later_moment).inclusive

    end

    it 'new solicitude has today date' do
      body = {
        'applicantName': Fixtures::APPLICANT_NAME,
        'applicantSurname': Fixtures::APPLICANT_SURNAME,
        'applicantEmail': Fixtures::APPLICANT_EMAIL,
        'applicantPhonenumber': Fixtures::APPLICANT_PHONENUMBER,
        'text': Fixtures::TEXT,
        'applicantId': "",
        'date': '',
        'companyCif': ""
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
        'applicantName': Fixtures::APPLICANT_NAME,
        'applicantSurname': Fixtures::APPLICANT_SURNAME,
        'applicantEmail': Fixtures::APPLICANT_EMAIL,
        'applicantPhonenumber': Fixtures::APPLICANT_PHONENUMBER,
        'text': Fixtures::TEXT,
        'applicantId': "",
        'date': '',
        'companyCif': ""
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
        'applicantName': Fixtures::APPLICANT_NAME,
        'applicantSurname': Fixtures::APPLICANT_SURNAME,
        'applicantEmail': Fixtures::APPLICANT_EMAIL,
        'applicantPhonenumber': Fixtures::APPLICANT_PHONENUMBER,
        'text': Fixtures::TEXT,
        'applicantId': "",
        'date': Fixtures::DATE,
        'companyCif': ""
        }.to_json
      post_create_solicitude(first_body)
      second_body = {
        'applicantName': Fixtures::APPLICANT_NAME,
        'applicantSurname': Fixtures::APPLICANT_SURNAME,
        'applicantEmail': Fixtures::APPLICANT_EMAIL,
        'applicantPhonenumber': Fixtures::APPLICANT_PHONENUMBER,
        'text': Fixtures::TEXT,
        'applicantId': "",
        'date': Fixtures::DATE,
        'companyCif': ""
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

    it 'knows how many times is one company in solicitudes' do
      post 'fixtures/clean'
      params = {"cif": Fixtures::COMPANY_CIF}.to_json
      post '/api/count-company-in-solicitudes', params

      response = JSON.parse(last_response.body)
      expect(response['data']).to eq(0)

      solicitude = {
        "applicantPhonenumber": Fixtures::APPLICANT_PHONENUMBER,
        "text": Fixtures::TEXT,
        'date': Fixtures::DATE,
        'applicantId': "",
        "companyName": Fixtures::COMPANY_NAME,
  			"companyCif": Fixtures::COMPANY_CIF
      }.to_json

      post '/api/create-solicitude', solicitude

      params = {"cif": Fixtures::COMPANY_CIF}.to_json
      post '/api/count-company-in-solicitudes', params

      response = JSON.parse(last_response.body)
      expect(response['data']).to eq(1)
    end
  end
  context 'retrieve solicitude' do
    before(:each) do
      post 'fixtures/clean'
    end

    it 'returns one solicitude' do
      body = {
        'applicantName': Fixtures::APPLICANT_NAME,
        'applicantSurname': Fixtures::APPLICANT_SURNAME,
        'applicantEmail': Fixtures::APPLICANT_EMAIL,
        'applicantPhonenumber': Fixtures::APPLICANT_PHONENUMBER,
        'text': Fixtures::TEXT,
        'applicantId': "",
        'date': Fixtures::DATE,
        'companyCif': ""
      }.to_json

      post_create_solicitude(body)

      created_solicitude = JSON.parse(last_response.body)

      id = {id: created_solicitude['creation_moment']}.to_json

      post '/api/retrieve-solicitude', id

      solicitude = JSON.parse(last_response.body)

      expect(solicitude['data']['text']).to eq(Fixtures::TEXT)
      expect(solicitude['data']['date']).to eq(Fixtures::DATE)
      expect(solicitude['data']['applicant_name']).to eq(Fixtures::APPLICANT_NAME)
      expect(solicitude['data']['applicant_surname']).to eq(Fixtures::APPLICANT_SURNAME)
      expect(solicitude['data']['applicant_email']).to eq(Fixtures::APPLICANT_EMAIL)
      expect(solicitude['data']['applicant_phonenumber']).to eq(Fixtures::APPLICANT_PHONENUMBER)
    end
  end

  context 'of the applicant' do
    before(:each) do
      post 'fixtures/clean'
    end

    it 'search matches by filter' do
      first_body = {
        'applicantName': Fixtures::APPLICANT_NAME,
        'applicantSurname': Fixtures::APPLICANT_SURNAME,
        'applicantEmail': Fixtures::APPLICANT_EMAIL,
        'applicantPhonenumber': Fixtures::APPLICANT_PHONENUMBER,
        'text': Fixtures::TEXT,
        'applicantId': "",
        'date': Fixtures::DATE,
        'companyCif': ""
        }.to_json
      post_create_solicitude(first_body)
      second_body = {
        'applicantName': Fixtures::APPLICANT_NAME_2,
        'applicantSurname': Fixtures::APPLICANT_SURNAME_2,
        'applicantEmail': Fixtures::APPLICANT_EMAIL_2,
        'applicantPhonenumber': Fixtures::APPLICANT_PHONENUMBER_2,
        'text': Fixtures::TEXT,
        'applicantId': "",
        'date': Fixtures::DATE,
        'companyCif': ""
        }.to_json
      post_create_solicitude(second_body)

      matches_body = {
        'applicantName': '',
        'applicantSurname': Fixtures::APPLICANT_SURNAME_2,
        'applicantEmail': '',
        'applicantPhonenumber': ''
      }.to_json
      post '/api/applicant-matches', matches_body
      response = JSON.parse(last_response.body)
      expect(response['data'][0]['phonenumber']).to eq(Fixtures::APPLICANT_PHONENUMBER_2)

      matches_body = {
        'applicantName': Fixtures::APPLICANT_NAME,
        'applicantSurname': '',
        'applicantEmail': '',
        'applicantPhonenumber': ''
      }.to_json
      post '/api/applicant-matches', matches_body
      response = JSON.parse(last_response.body)
      expect(response['data'].length).to be >= 2
    end
  end

  context 'update solicitude' do

    before(:each) do
      post 'fixtures/clean'
    end

    it 'endpoint update solicitude ' do
      body = {
        'applicantName': Fixtures::APPLICANT_NAME,
        'applicantSurname': Fixtures::APPLICANT_SURNAME,
        'applicantEmail': Fixtures::APPLICANT_EMAIL,
        'applicantPhonenumber': Fixtures::APPLICANT_PHONENUMBER,
        'text': Fixtures::TEXT,
        'date': Fixtures::DATE,
        'applicantId': "",
        'companyName': Fixtures::COMPANY_NAME,
  			'companyCif': Fixtures::COMPANY_CIF
      }.to_json

      post_create_solicitude(body)
      created_solicitude = JSON.parse(last_response.body)
      creation_moment = created_solicitude['creation_moment']


      update_solicitude = {
  			'applicantPhonenumber': Fixtures::APPLICANT_PHONENUMBER,
  			'text': Fixtures::TEXT_2,
  			'date': Fixtures::DATE,
  			'applicantEmail': Fixtures::APPLICANT_EMAIL,
        'applicantId': "",
  			'companyCif': Fixtures::COMPANY_CIF,
        'creation_moment': creation_moment
  		}.to_json

      post '/api/update-solicitude', update_solicitude
      response = JSON.parse(last_response.body)

      expect(response['text']).to eq(Fixtures::TEXT_2)
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
