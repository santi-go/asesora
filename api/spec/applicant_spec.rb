require 'net/http'
require 'rspec'
require 'json'
require 'rack/test'
require 'date'

require_relative '../system/services/applicant/service'
require_relative './fixtures/asesora_with_fixtures'
require_relative './fixtures/fixtures'

describe 'Solicitude Applicant' do
  include Rack::Test::Methods

  def app
    AsesoraWithFixtures
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

    it 'update applicant data' do
        first_body = {
          'date': Fixtures::DATE,
          'applicantName': Fixtures::APPLICANT_NAME,
          'applicantSurname': Fixtures::APPLICANT_SURNAME,
          'applicantEmail': Fixtures::APPLICANT_EMAIL,
          'applicantPhonenumber': Fixtures::APPLICANT_PHONENUMBER,
          'text': Fixtures::TEXT,
          'applicantId': "",
          'companyCif': ""
          }.to_json

        post_create_solicitude(first_body)
        response = JSON.parse(last_response.body)
        applicant_id = response['applicant']

        second_body = {
          'applicantName': Fixtures::APPLICANT_NAME,
          'applicantSurname': Fixtures::APPLICANT_SURNAME,
          'applicantEmail': Fixtures::APPLICANT_EMAIL,
          'applicantPhonenumber': Fixtures::APPLICANT_PHONENUMBER_2,
          'applicantId': applicant_id,
          }.to_json

        post '/api/update-applicant', second_body
        response = JSON.parse(last_response.body)
        applicant_phone = response['phonenumber']

        expect(applicant_phone).to eq(Fixtures::APPLICANT_PHONENUMBER_2)
    end

    it 'deletes applicant' do
      solicitude = {
        'date': Fixtures::DATE,
        'applicantName': Fixtures::APPLICANT_NAME,
        'applicantSurname': Fixtures::APPLICANT_SURNAME,
        'applicantEmail': Fixtures::APPLICANT_EMAIL,
        'applicantPhonenumber': Fixtures::APPLICANT_PHONENUMBER,
        'text': Fixtures::TEXT,
        'applicantId': "",
        'companyCif': ""
        }.to_json
      post_create_solicitude(solicitude)
      response = JSON.parse(last_response.body)
      applicant_id = response['applicant']

      before_delete = Applicant::Service.retrieve(applicant_id)
      delete_applicant(applicant_id)
      after_delete = Applicant::Service.retrieve(applicant_id)

      expect(before_delete).not_to eq(after_delete)
    end
  end

  private

  def post_create_solicitude(body_created)
    post '/api/create-solicitude', body_created
  end

  def delete_applicant(applicant_id)
      Applicant::Service.delete(applicant_id)
  end
end
