require 'net/http'
require 'rspec'
require 'json'
require 'rack/test'
require "date"

require_relative '../system/services/companies/service'
require_relative './fixtures/asesora_with_fixtures'

describe 'Company Api' do

  include Rack::Test::Methods

  def app
    AsesoraWithFixtures
  end

  before(:each) do
    post 'fixtures/clean'
    end

  it 'retrieves company if exists' do
    solicitude = {
      "applicantName": AsesoraWithFixtures::APPLICANT_NAME,
      "applicantSurname": AsesoraWithFixtures::APPLICANT_SURNAME,
      "applicantEmail": AsesoraWithFixtures::APPLICANT_EMAIL,
      "applicantPhonenumber": AsesoraWithFixtures::APPLICANT_PHONENUMBER,
      "text": AsesoraWithFixtures::TEXT,
      "date": AsesoraWithFixtures::DATE,
      'applicantId': "",
      "companyName": AsesoraWithFixtures::COMPANY_NAME,
			"companyCif": AsesoraWithFixtures::COMPANY_CIF,
      "companyEmployees": AsesoraWithFixtures::COMPANY_EMPLOYEES,
			"companyCnae": AsesoraWithFixtures::COMPANY_CNAE
    }.to_json

    post '/api/create-solicitude', solicitude

    post '/api/duplicated-company', {"id": AsesoraWithFixtures::COMPANY_CIF}.to_json
    company = JSON.parse(last_response.body)

    expect(company["name"]).to eq(AsesoraWithFixtures::COMPANY_NAME)
    expect(company["cif"]).to eq(AsesoraWithFixtures::COMPANY_CIF)
    expect(company["employees"]).to eq(AsesoraWithFixtures::COMPANY_EMPLOYEES)
    expect(company["cnae"]).to eq(AsesoraWithFixtures::COMPANY_CNAE)
  end

  it "knows when company is not registered yet" do
    post '/api/duplicated-company', {"id": "not_existing_cif"}.to_json
    pepe = JSON.parse(last_response.body)
    expect(pepe).to eq({})
  end

  it 'update data in edition mode' do
    first_solicitude = {
      "applicantName": AsesoraWithFixtures::APPLICANT_NAME,
      "applicantSurname": AsesoraWithFixtures::APPLICANT_SURNAME,
      "applicantEmail": AsesoraWithFixtures::APPLICANT_EMAIL,
      "applicantPhonenumber": AsesoraWithFixtures::APPLICANT_PHONENUMBER,
      "text": AsesoraWithFixtures::TEXT,
      "date": AsesoraWithFixtures::DATE,
      'applicantId': "",
      "companyName": AsesoraWithFixtures::COMPANY_NAME,
			"companyCif": AsesoraWithFixtures::COMPANY_CIF,
      "companyEmployees": AsesoraWithFixtures::COMPANY_EMPLOYEES,
			"companyCnae": AsesoraWithFixtures::COMPANY_CNAE
    }.to_json

    post '/api/create-solicitude', first_solicitude

    update_company = {
      "companyName": AsesoraWithFixtures::COMPANY_NAME_2,
			"companyCif": AsesoraWithFixtures::COMPANY_CIF,
      "companyEmployees": AsesoraWithFixtures::COMPANY_EMPLOYEES,
			"companyCnae": AsesoraWithFixtures::COMPANY_CNAE
    }.to_json

    post '/api/update-company', update_company
    company = JSON.parse(last_response.body)

    expect(company["name"]).to eq(AsesoraWithFixtures::COMPANY_NAME_2)
  end

  it 'create company when cif is differentin edition mode' do

    first_solicitude = {
      "applicantName": AsesoraWithFixtures::APPLICANT_NAME,
      "applicantSurname": AsesoraWithFixtures::APPLICANT_SURNAME,
      "applicantEmail": AsesoraWithFixtures::APPLICANT_EMAIL,
      "applicantPhonenumber": AsesoraWithFixtures::APPLICANT_PHONENUMBER,
      "text": AsesoraWithFixtures::TEXT,
      "date": AsesoraWithFixtures::DATE,
      'applicantId': "",
      "companyName": AsesoraWithFixtures::COMPANY_NAME,
			"companyCif": AsesoraWithFixtures::COMPANY_CIF,
      "companyEmployees": AsesoraWithFixtures::COMPANY_EMPLOYEES,
			"companyCnae": AsesoraWithFixtures::COMPANY_CNAE
    }.to_json

    post '/api/create-solicitude', first_solicitude

    update_company = {
      "companyName": AsesoraWithFixtures::COMPANY_NAME,
			"companyCif": AsesoraWithFixtures::COMPANY_CIF_2,
      "companyEmployees": AsesoraWithFixtures::COMPANY_EMPLOYEES,
      "companyCnae": AsesoraWithFixtures::COMPANY_CNAE
    }.to_json

    post '/api/update-company', update_company

    post '/api/duplicated-company', {"id": AsesoraWithFixtures::COMPANY_CIF_2}.to_json
    company = JSON.parse(last_response.body)

    expect(company["cif"]).to eq(AsesoraWithFixtures::COMPANY_CIF_2)
    expect(company["name"]).to eq(AsesoraWithFixtures::COMPANY_NAME)
  end

  it 'deletes company' do
    solicitude = {
      'date': AsesoraWithFixtures::DATE,
      'applicantName': AsesoraWithFixtures::APPLICANT_NAME,
      'applicantSurname': AsesoraWithFixtures::APPLICANT_SURNAME,
      'applicantEmail': AsesoraWithFixtures::APPLICANT_EMAIL,
      'applicantPhonenumber': AsesoraWithFixtures::APPLICANT_PHONENUMBER,
      'text': AsesoraWithFixtures::TEXT,
      'applicantId': "",
      "companyName": AsesoraWithFixtures::COMPANY_NAME,
			"companyCif": AsesoraWithFixtures::COMPANY_CIF,
      "companyEmployees": AsesoraWithFixtures::COMPANY_EMPLOYEES,
      "companyCnae": AsesoraWithFixtures::COMPANY_CNAE
      }.to_json
    post_create_solicitude(solicitude)
    response = JSON.parse(last_response.body)
    company_id = response['company']

    before_delete = Companies::Service.retrieve(company_id)
    delete_company(company_id)
    after_delete = Companies::Service.retrieve(company_id)

    expect(before_delete).not_to eq(after_delete)
  end

  private

  def post_create_solicitude(body_created)
    post '/api/create-solicitude', body_created
  end

  def delete_company(company_id)
      Companies::Service.delete(company_id)
  end

end
