require 'net/http'
require 'rspec'
require 'json'
require 'rack/test'
require "date"

require_relative './fixtures/fixtures'

describe 'Company Api' do

  include Rack::Test::Methods

  def app
    Fixtures
  end

  before(:each) do
    post 'fixtures/clean'
    end

  it 'retrieves company if exists' do
    solicitude = {
      "applicantName": Fixtures::NAME,
      "applicantSurname": Fixtures::SURNAME,
      "applicantEmail": Fixtures::EMAIL,
      "applicantPhonenumber": Fixtures::PHONENUMBER,
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

  it "don't saves a duplicated company" do
    first_solicitude = {
      "applicantName": Fixtures::NAME,
      "applicantSurname": Fixtures::SURNAME,
      "applicantEmail": Fixtures::EMAIL,
      "applicantPhonenumber": Fixtures::PHONENUMBER,
      "text": Fixtures::TEXT,
      "date": Fixtures::DATE,
      'applicantId': "",
      "companyName": Fixtures::COMPANY_NAME,
			"companyCif": Fixtures::COMPANY_CIF,
      "companyEmployees": Fixtures::COMPANY_EMPLOYEES,
			"companyCnae": Fixtures::COMPANY_CNAE
    }.to_json

    post '/api/create-solicitude', first_solicitude

    second_solicitude = {
      "applicantName": Fixtures::NAME,
      "applicantSurname": Fixtures::SURNAME,
      "applicantEmail": Fixtures::EMAIL,
      "applicantPhonenumber": Fixtures::PHONENUMBER,
      "text": Fixtures::TEXT,
      "date": Fixtures::DATE,
      'applicantId': "",
      "companyName": Fixtures::COMPANY_NAME_2,
			"companyCif": Fixtures::COMPANY_CIF,
      "companyEmployees": Fixtures::COMPANY_EMPLOYEES,
			"companyCnae": Fixtures::COMPANY_CNAE
    }.to_json

    post '/api/create-solicitude', second_solicitude

    post '/api/duplicated-company', {"id": Fixtures::COMPANY_CIF}.to_json
    company = JSON.parse(last_response.body)

    expect(company["name"]).to eq(Fixtures::COMPANY_NAME)
  end
  it 'update data in edition mode' do

    first_solicitude = {
      "applicantName": Fixtures::NAME,
      "applicantSurname": Fixtures::SURNAME,
      "applicantEmail": Fixtures::EMAIL,
      "applicantPhonenumber": Fixtures::PHONENUMBER,
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
      "applicantName": Fixtures::NAME,
      "applicantSurname": Fixtures::SURNAME,
      "applicantEmail": Fixtures::EMAIL,
      "applicantPhonenumber": Fixtures::PHONENUMBER,
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
end
