require 'net/http'
require 'rspec'
require 'json'
require 'rack/test'
require 'date'

require_relative  '../system/services/solicitudes/service'
require_relative './fixtures/asesora_with_fixtures'
require_relative './fixtures/solicitude_builder'

describe 'Solicitude Api' do
  include Rack::Test::Methods

  def app
    AsesoraWithFixtures
  end

  after(:each) do
    post 'fixtures/clean'
  end

  context 'delete solicitude by endpoint' do
    it 'returns error when solicitude not exists'  do
      id = {id: 1528913921360}.to_json

      post '/api/delete-solicitude', id
      response = last_response.status

      expect(response).to eq(500)
    end

    it 'deletes solicitude' do
      solicitude = create_solicitude_one()
      id = {id: solicitude['creation_moment']}.to_json

      post_delete_solicitude(id)

      expect_solicitude_deleted(id)
    end

    context 'when it leaves orphans' do
      it 'deletes the applicant' do
        solicitude = create_solicitude_one()
        id = {id: solicitude['creation_moment']}.to_json
        applicant_id = solicitude['applicant']

        post_delete_solicitude(id)
        applicant = Applicant::Service.retrieve(applicant_id)

        expect(applicant['id']).to be_nil
      end

      it 'deletes the company' do
        solicitude = create_solicitude_one()
        id = {id: solicitude['creation_moment']}.to_json
        company_id = solicitude['company']

        post_delete_solicitude(id)
        company = Companies::Service.retrieve(company_id)

        expect(company['cif']).to be_nil
      end
    end

    context 'when not leaves orphans' do
      it 'not deletes the applicant' do
        solicitude = create_solicitude_one()
        id = {id: solicitude['creation_moment']}.to_json
        applicant_id = solicitude['applicant']
        solicitude_two = create_solicitude_two(applicant_id)

        post_delete_solicitude(id)
        applicant = Applicant::Service.retrieve(applicant_id)

        expect(applicant['id']).not_to be_nil
      end

      it 'not deletes the company' do
        solicitude = create_solicitude_one()
        id = {id: solicitude['creation_moment']}.to_json
        company_id = solicitude['company']
        applicant_id = solicitude['applicant']
        solicitude_two = create_solicitude_two(applicant_id)

        post_delete_solicitude(id)
        company = Companies::Service.retrieve(company_id)

        expect(company['cif']).not_to be_nil
      end
    end

    def create_solicitude_one
      body = {
        'applicantName': AsesoraWithFixtures::APPLICANT_NAME,
        'applicantSurname': AsesoraWithFixtures::APPLICANT_SURNAME,
        'applicantEmail': AsesoraWithFixtures::APPLICANT_EMAIL,
        'applicantPhonenumber': AsesoraWithFixtures::APPLICANT_PHONENUMBER,
        'text': AsesoraWithFixtures::TEXT,
        'date': AsesoraWithFixtures::DATE,
        'applicantId': "",
        "companyName": AsesoraWithFixtures::COMPANY_NAME,
        "companyCif": AsesoraWithFixtures::COMPANY_CIF
      }.to_json

      post_create_solicitude(body)
      created_solicitude = JSON.parse(last_response.body)
      created_solicitude
    end

    def create_solicitude_two(applicant_id)
      body = {
        'applicantName': AsesoraWithFixtures::APPLICANT_NAME,
        'applicantSurname': AsesoraWithFixtures::APPLICANT_SURNAME,
        'applicantEmail': AsesoraWithFixtures::APPLICANT_EMAIL,
        'applicantPhonenumber': AsesoraWithFixtures::APPLICANT_PHONENUMBER,
        'text': AsesoraWithFixtures::TEXT_2,
        'date': "",
        'applicantId': applicant_id,
        "companyName": AsesoraWithFixtures::COMPANY_NAME,
        "companyCif": AsesoraWithFixtures::COMPANY_CIF
      }.to_json

      post_create_solicitude(body)
      created_solicitude = JSON.parse(last_response.body)
      created_solicitude
    end

    def expect_solicitude_deleted(id)
      post '/api/retrieve-solicitude', id
      solicitude = JSON.parse(last_response.body)
      expect(solicitude['data']).to eq({})
    end
  end

  context 'create solicitude' do

    before(:each) do
      post 'fixtures/clean'
    end

    it 'returns a brand new solicitude' do
      body = {
        'applicantName': AsesoraWithFixtures::APPLICANT_NAME,
        'applicantSurname': AsesoraWithFixtures::APPLICANT_SURNAME,
        'applicantEmail': AsesoraWithFixtures::APPLICANT_EMAIL,
        'applicantPhonenumber': AsesoraWithFixtures::APPLICANT_PHONENUMBER,
        'text': AsesoraWithFixtures::TEXT,
        'date': AsesoraWithFixtures::DATE,
        'applicantId': "",
        'companyCif': ""
      }.to_json

      post_create_solicitude(body)

      created_solicitude = JSON.parse(last_response.body)

      expect(created_solicitude['applicant']).not_to be_empty
      expect(created_solicitude['text']).to eq(AsesoraWithFixtures::TEXT)
      expect(created_solicitude['date']).to eq(AsesoraWithFixtures::DATE)
      expect(created_solicitude['creation_moment']).not_to be_nil
    end

    it 'returns a new solicitude with existent applicant id' do
      body = {
        'applicantName': AsesoraWithFixtures::APPLICANT_NAME,
        'applicantSurname': AsesoraWithFixtures::APPLICANT_SURNAME,
        'applicantEmail': AsesoraWithFixtures::APPLICANT_EMAIL,
        'applicantPhonenumber': AsesoraWithFixtures::APPLICANT_PHONENUMBER,
        'text': AsesoraWithFixtures::TEXT,
        'date': AsesoraWithFixtures::DATE,
        'applicantId': "",
        'companyCif': ""
      }.to_json

      post_create_solicitude(body)
      created_solicitude = JSON.parse(last_response.body)
      applicant_id = created_solicitude['applicant']
      expect(applicant_id).not_to be_empty

      body_with_id = {
        'applicantName': AsesoraWithFixtures::APPLICANT_NAME_2,
        'applicantSurname': AsesoraWithFixtures::APPLICANT_SURNAME_2,
        'applicantEmail': AsesoraWithFixtures::APPLICANT_EMAIL_2,
        'applicantPhonenumber': AsesoraWithFixtures::APPLICANT_PHONENUMBER_2,
        'text': AsesoraWithFixtures::TEXT,
        'date': AsesoraWithFixtures::DATE,
        'applicantId': applicant_id,
        'companyCif': ""
      }.to_json

      post_create_solicitude(body_with_id)

      matches_body = {
        'applicantName': '',
        'applicantSurname': AsesoraWithFixtures::APPLICANT_SURNAME_2,
        'applicantEmail': '',
        'applicantPhonenumber': ''
      }.to_json
      post '/api/applicant-matches', matches_body
      response = JSON.parse(last_response.body)
      expect(response['data'].length).to eq(0)
    end

    it 'generate creation moment in milliseconds' do
      body = {
        'applicantName': AsesoraWithFixtures::APPLICANT_NAME,
        'applicantSurname': AsesoraWithFixtures::APPLICANT_SURNAME,
        'applicantEmail': AsesoraWithFixtures::APPLICANT_EMAIL,
        'applicantPhonenumber': AsesoraWithFixtures::APPLICANT_PHONENUMBER,
        'text': AsesoraWithFixtures::TEXT,
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
        'applicantName': AsesoraWithFixtures::APPLICANT_NAME,
        'applicantSurname': AsesoraWithFixtures::APPLICANT_SURNAME,
        'applicantEmail': AsesoraWithFixtures::APPLICANT_EMAIL,
        'applicantPhonenumber': AsesoraWithFixtures::APPLICANT_PHONENUMBER,
        'text': AsesoraWithFixtures::TEXT,
        'applicantId': "",
        'date': '',
        'companyCif': ""
      }.to_json
      post_create_solicitude(body)
      today = Date.today.strftime(in_english_format)

      created_solicitude = JSON.parse(last_response.body)

      expect(created_solicitude['applicant']).not_to be_empty
      expect(created_solicitude['text']).to eq(AsesoraWithFixtures::TEXT)
      expect(created_solicitude['date']).to eq(today)
    end
    context "memento" do
      it 'saves company in latest state' do
        first_solicitude = {
          'applicantName': AsesoraWithFixtures::APPLICANT_NAME,
          'applicantSurname': AsesoraWithFixtures::APPLICANT_SURNAME,
          'applicantEmail': AsesoraWithFixtures::APPLICANT_EMAIL,
          'applicantPhonenumber': AsesoraWithFixtures::APPLICANT_PHONENUMBER,
          'text': AsesoraWithFixtures::TEXT,
          'date': AsesoraWithFixtures::DATE,
          'applicantId': "",
          'companyName': AsesoraWithFixtures::COMPANY_NAME,
          'companyCif': AsesoraWithFixtures::COMPANY_CIF
        }
        first_creation_moment = create_solicitude(first_solicitude)

        wait_for_new_edition_moment

        second_solicitude = {
          'applicantName': AsesoraWithFixtures::APPLICANT_NAME_2,
          'applicantSurname': AsesoraWithFixtures::APPLICANT_SURNAME,
          'applicantEmail': AsesoraWithFixtures::APPLICANT_EMAIL,
          'applicantPhonenumber': AsesoraWithFixtures::APPLICANT_PHONENUMBER,
          'text': AsesoraWithFixtures::TEXT,
          'date': AsesoraWithFixtures::DATE,
          'applicantId': "",
          'companyName': AsesoraWithFixtures::COMPANY_NAME_2,
          'companyCif': AsesoraWithFixtures::COMPANY_CIF
        }
        second_creation_moment = create_solicitude(second_solicitude)

        first_solicitude = retrieve_solicitude(first_creation_moment)
        second_solicitude = retrieve_solicitude(second_creation_moment)

        expect(first_solicitude['data']['company_name']).to eq(AsesoraWithFixtures::COMPANY_NAME)
        expect(second_solicitude['data']['company_name']).to eq(AsesoraWithFixtures::COMPANY_NAME_2)
      end
    end
  end

  context 'retrieve solicitude' do
    before(:each) do
      post 'fixtures/pristine'
    end

    it 'returns all solicitudes' do
      post '/fixtures/pristine'

      post '/api/retrieve-solicitudes'

      solicitudes = JSON.parse(last_response.body)
      solicitudes_count = solicitudes['data'].count

      expect(solicitudes_count).to eq(AsesoraWithFixtures::SOLICITUDES_COUNT)
    end

    it 'when date is the same sorts solicitudes in descendent creation moment' do
      post '/fixtures/clean'

      same_date = AsesoraWithFixtures::DATE

      first_solicitude = SolicitudeBuilder.default.with.text('Solicitude 1').date(same_date).build
      post_create_solicitude(first_solicitude.to_json)

      second_solicitude = SolicitudeBuilder.default.with.text('Solicitude 2').date(same_date).build
      post_create_solicitude(second_solicitude.to_json)

      post '/api/retrieve-solicitudes'
      response = JSON.parse(last_response.body)
      solicitudes = response['data']

      expect(solicitudes.count).to eq(2)
      expect(solicitudes[0]['text']).to eq('Solicitude 2')
      expect(solicitudes[1]['text']).to eq('Solicitude 1')
    end

    it 'knows how many times is one company in solicitudes' do
      post 'fixtures/clean'
      params = {"cif": AsesoraWithFixtures::COMPANY_CIF}.to_json
      post '/api/count-company-in-solicitudes', params

      response = JSON.parse(last_response.body)
      expect(response['data']).to eq(0)

      solicitude = {
        "applicantPhonenumber": AsesoraWithFixtures::APPLICANT_PHONENUMBER,
        "text": AsesoraWithFixtures::TEXT,
        'date': AsesoraWithFixtures::DATE,
        'applicantId': "",
        "companyName": AsesoraWithFixtures::COMPANY_NAME,
  			"companyCif": AsesoraWithFixtures::COMPANY_CIF
      }.to_json

      post '/api/create-solicitude', solicitude

      params = {"cif": AsesoraWithFixtures::COMPANY_CIF}.to_json
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
        'applicantName': AsesoraWithFixtures::APPLICANT_NAME,
        'applicantSurname': AsesoraWithFixtures::APPLICANT_SURNAME,
        'applicantEmail': AsesoraWithFixtures::APPLICANT_EMAIL,
        'applicantPhonenumber': AsesoraWithFixtures::APPLICANT_PHONENUMBER,
        'text': AsesoraWithFixtures::TEXT,
        'applicantId': "",
        'date': AsesoraWithFixtures::DATE,
        'companyCif': ""
      }.to_json

      post_create_solicitude(body)

      created_solicitude = JSON.parse(last_response.body)

      id = {id: created_solicitude['creation_moment']}.to_json

      post '/api/retrieve-solicitude', id

      solicitude = JSON.parse(last_response.body)

      expect(solicitude['data']['text']).to eq(AsesoraWithFixtures::TEXT)
      expect(solicitude['data']['date']).to eq(AsesoraWithFixtures::DATE)
      expect(solicitude['data']['applicant_name']).to eq(AsesoraWithFixtures::APPLICANT_NAME)
      expect(solicitude['data']['applicant_surname']).to eq(AsesoraWithFixtures::APPLICANT_SURNAME)
      expect(solicitude['data']['applicant_email']).to eq(AsesoraWithFixtures::APPLICANT_EMAIL)
      expect(solicitude['data']['applicant_phonenumber']).to eq(AsesoraWithFixtures::APPLICANT_PHONENUMBER)
    end
  end

  context 'update solicitude' do

    before(:each) do
      post 'fixtures/clean'
    end

    it 'endpoint update solicitude ' do
      body = {
        'applicantName': AsesoraWithFixtures::APPLICANT_NAME,
        'applicantSurname': AsesoraWithFixtures::APPLICANT_SURNAME,
        'applicantEmail': AsesoraWithFixtures::APPLICANT_EMAIL,
        'applicantPhonenumber': AsesoraWithFixtures::APPLICANT_PHONENUMBER,
        'text': AsesoraWithFixtures::TEXT,
        'date': AsesoraWithFixtures::DATE,
        'applicantId': "",
        'companyName': AsesoraWithFixtures::COMPANY_NAME,
  			'companyCif': AsesoraWithFixtures::COMPANY_CIF
      }.to_json

      post_create_solicitude(body)
      created_solicitude = JSON.parse(last_response.body)
      creation_moment = created_solicitude['creation_moment']


      update_solicitude = {
  			'applicantPhonenumber': AsesoraWithFixtures::APPLICANT_PHONENUMBER,
  			'text': AsesoraWithFixtures::TEXT_2,
  			'date': AsesoraWithFixtures::DATE,
  			'applicantEmail': AsesoraWithFixtures::APPLICANT_EMAIL,
        'applicantId': "",
  			'companyCif': AsesoraWithFixtures::COMPANY_CIF,
        'creation_moment': creation_moment
  		}.to_json

      post '/api/update-solicitude', update_solicitude
      response = JSON.parse(last_response.body)

      expect(response['text']).to eq(AsesoraWithFixtures::TEXT_2)
    end

    context 'memento' do
      it 'retrieves company in latest state' do
        first_solicitude = SolicitudeBuilder.default.with.company_name(AsesoraWithFixtures::COMPANY_NAME).build
        first_creation_moment = create_solicitude(first_solicitude)
        wait_for_new_edition_moment
        second_solicitude = SolicitudeBuilder.default.with.company_name(AsesoraWithFixtures::COMPANY_NAME).build
        second_creation_moment = create_solicitude(second_solicitude)
        wait_for_new_edition_moment

        same_company_with_new_data = {
          'companyName': AsesoraWithFixtures::COMPANY_NAME_2,
          'companyCif': AsesoraWithFixtures::COMPANY_CIF
        }
        post '/api/update-company', same_company_with_new_data.to_json
        second_solicitude = SolicitudeBuilder.default.with.company_name(AsesoraWithFixtures::COMPANY_NAME).creation_moment(second_creation_moment).build
        update_solicitude(second_solicitude)

        first_solicitude = retrieve_solicitude(first_creation_moment)
        second_solicitude = retrieve_solicitude(second_creation_moment)
        expect(first_solicitude['data']['company_name']).to eq(AsesoraWithFixtures::COMPANY_NAME)
        expect(second_solicitude['data']['company_name']).to eq(AsesoraWithFixtures::COMPANY_NAME_2)
      end
    end
  end

  private

  def create_solicitude(solicitude)
    post_create_solicitude(solicitude.to_json)
    response = JSON.parse(last_response.body)

    response['creation_moment']
  end

  def update_solicitude(solicitude)
    post '/api/update-solicitude', solicitude.to_json
  end

  def wait_for_new_edition_moment
    sleep 1
  end

  def retrieve_solicitude(creation_moment)
    post '/api/retrieve-solicitude', { 'id' => creation_moment }.to_json

    JSON.parse(last_response.body)
  end

  def in_microseconds
    return '%Q'
  end

  def in_english_format
    return '%Y-%m-%d'
  end

  def post_create_solicitude(body_created)
    post '/api/create-solicitude', body_created
  end

  def post_delete_solicitude(id)
    post '/api/delete-solicitude', id
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
