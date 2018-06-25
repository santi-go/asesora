require 'net/http'
require 'rspec'
require 'json'
require 'rack/test'
require "date"

require_relative '../system/services/companies/service'
require_relative './fixtures/asesora_with_fixtures'
require_relative './fixtures/fixtures'

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
      "applicantName": Fixtures::APPLICANT_NAME,
      "applicantSurname": Fixtures::APPLICANT_SURNAME,
      "applicantEmail": Fixtures::APPLICANT_EMAIL,
      "applicantPhonenumber": Fixtures::APPLICANT_PHONENUMBER,
      "text": Fixtures::TEXT,
      "date": Fixtures::DATE,
      'applicantId': "",
      "companyName": Fixtures::COMPANY_NAME,
			"companyCif": Fixtures::COMPANY_CIF,
      "companyEmployees": Fixtures::COMPANY_EMPLOYEES,
			"companyCnae": Fixtures::COMPANY_CNAE
    }.to_json

    post '/api/create-solicitude', solicitude

    post '/api/duplicated-company', {"id": Fixtures::COMPANY_CIF}.to_json
    company = JSON.parse(last_response.body)

    expect(company["name"]).to eq(Fixtures::COMPANY_NAME)
    expect(company["cif"]).to eq(Fixtures::COMPANY_CIF)
    expect(company["employees"]).to eq(Fixtures::COMPANY_EMPLOYEES)
    expect(company["cnae"]).to eq(Fixtures::COMPANY_CNAE)
  end

  it "knows when company is not registered yet" do
    post '/api/duplicated-company', {"id": "not_existing_cif"}.to_json
    pepe = JSON.parse(last_response.body)
    expect(pepe).to eq({})
  end

  it 'update data in edition mode' do
    first_solicitude = {
      "applicantName": Fixtures::APPLICANT_NAME,
      "applicantSurname": Fixtures::APPLICANT_SURNAME,
      "applicantEmail": Fixtures::APPLICANT_EMAIL,
      "applicantPhonenumber": Fixtures::APPLICANT_PHONENUMBER,
      "text": Fixtures::TEXT,
      "date": Fixtures::DATE,
      'applicantId': "",
      "companyName": Fixtures::COMPANY_NAME,
			"companyCif": Fixtures::COMPANY_CIF,
      "companyEmployees": Fixtures::COMPANY_EMPLOYEES,
			"companyCnae": Fixtures::COMPANY_CNAE
    }.to_json

    post '/api/create-solicitude', first_solicitude

    update_company = {
      "companyName": Fixtures::COMPANY_NAME_2,
			"companyCif": Fixtures::COMPANY_CIF,
      "companyEmployees": Fixtures::COMPANY_EMPLOYEES,
			"companyCnae": Fixtures::COMPANY_CNAE
    }.to_json

    post '/api/update-company', update_company
    company = JSON.parse(last_response.body)

    expect(company["name"]).to eq(Fixtures::COMPANY_NAME_2)
  end

  it 'create company when cif is differentin edition mode' do

    first_solicitude = {
      "applicantName": Fixtures::APPLICANT_NAME,
      "applicantSurname": Fixtures::APPLICANT_SURNAME,
      "applicantEmail": Fixtures::APPLICANT_EMAIL,
      "applicantPhonenumber": Fixtures::APPLICANT_PHONENUMBER,
      "text": Fixtures::TEXT,
      "date": Fixtures::DATE,
      'applicantId': "",
      "companyName": Fixtures::COMPANY_NAME,
			"companyCif": Fixtures::COMPANY_CIF,
      "companyEmployees": Fixtures::COMPANY_EMPLOYEES,
			"companyCnae": Fixtures::COMPANY_CNAE
    }.to_json

    post '/api/create-solicitude', first_solicitude

    update_company = {
      "companyName": Fixtures::COMPANY_NAME,
			"companyCif": Fixtures::COMPANY_CIF_2,
      "companyEmployees": Fixtures::COMPANY_EMPLOYEES,
      "companyCnae": Fixtures::COMPANY_CNAE
    }.to_json

    post '/api/update-company', update_company

    post '/api/duplicated-company', {"id": Fixtures::COMPANY_CIF_2}.to_json
    company = JSON.parse(last_response.body)

    expect(company["cif"]).to eq(Fixtures::COMPANY_CIF_2)
    expect(company["name"]).to eq(Fixtures::COMPANY_NAME)
  end

  it 'deletes company' do
    solicitude = {
      'date': Fixtures::DATE,
      'applicantName': Fixtures::APPLICANT_NAME,
      'applicantSurname': Fixtures::APPLICANT_SURNAME,
      'applicantEmail': Fixtures::APPLICANT_EMAIL,
      'applicantPhonenumber': Fixtures::APPLICANT_PHONENUMBER,
      'text': Fixtures::TEXT,
      'applicantId': "",
      "companyName": Fixtures::COMPANY_NAME,
			"companyCif": Fixtures::COMPANY_CIF,
      "companyEmployees": Fixtures::COMPANY_EMPLOYEES,
      "companyCnae": Fixtures::COMPANY_CNAE
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
