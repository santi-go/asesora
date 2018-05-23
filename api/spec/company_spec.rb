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
      "name": Fixtures::NAME,
      "surname": Fixtures::SURNAME,
      "email": Fixtures::EMAIL,
      "phonenumber": Fixtures::PHONENUMBER,
      "text" => Fixtures::TEXT,
      "date" => Fixtures::DATE,
      'applicantId' => "",
      "companyName" => Fixtures::COMPANY_NAME,
			"companyCif" => Fixtures::COMPANY_CIF,
      "companyEmployees": Fixtures::COMPANY_EMPLOYEES,
			"companyCnae" => Fixtures::COMPANY_CNAE
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
      "name": Fixtures::NAME,
      "surname": Fixtures::SURNAME,
      "email": Fixtures::EMAIL,
      "phonenumber": Fixtures::PHONENUMBER,
      "text" => Fixtures::TEXT,
      "date" => Fixtures::DATE,
      'applicantId' => "",
      "companyName" => Fixtures::COMPANY_NAME,
			"companyCif" => Fixtures::COMPANY_CIF,
      "companyEmployees": Fixtures::COMPANY_EMPLOYEES,
			"companyCnae" => Fixtures::COMPANY_CNAE
    }.to_json

    post '/api/create-solicitude', first_solicitude

    second_solicitude = {
      "name": Fixtures::NAME,
      "surname": Fixtures::SURNAME,
      "email": Fixtures::EMAIL,
      "phonenumber": Fixtures::PHONENUMBER,
      "text" => Fixtures::TEXT,
      "date" => Fixtures::DATE,
      'applicantId' => "",
      "companyName" => Fixtures::COMPANY_NAME_2,
			"companyCif" => Fixtures::COMPANY_CIF,
      "companyEmployees": Fixtures::COMPANY_EMPLOYEES,
			"companyCnae" => Fixtures::COMPANY_CNAE
    }.to_json

    post '/api/create-solicitude', second_solicitude

    post '/api/duplicated-company', {"id": Fixtures::COMPANY_CIF}.to_json
    company = JSON.parse(last_response.body)

    expect(company["name"]).to eq(Fixtures::COMPANY_NAME)
  end
end
