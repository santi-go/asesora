require 'rspec'
require 'json'
require 'rack/test'

require_relative './fixtures/asesora_with_fixtures'
require_relative '../system/services/companies/service'

describe 'Companies' do

  include Rack::Test::Methods

  def app
    AsesoraWithFixtures
  end

  before(:each) do
	  post 'fixtures/pristine'
  end

  after(:each) do
    post 'fixtures/clean'
  end

	it 'returns a list filtered by criteria' do
		solicitude = {
			"applicantPhonenumber": AsesoraWithFixtures::APPLICANT_PHONENUMBER,
			"text": AsesoraWithFixtures::TEXT,
			"applicantemail": AsesoraWithFixtures::APPLICANT_EMAIL,
			"date": AsesoraWithFixtures::DATE,
      'applicantId': "",
			"companyName": AsesoraWithFixtures::COMPANY_NAME,
			"companyCif": AsesoraWithFixtures::COMPANY_CIF,
			"companyCnae": AsesoraWithFixtures::COMPANY_CNAE
		}.to_json

		post_create_solicitude(solicitude)

		body = {
			"name": "Rap",
			"cnae": "931 - Actividades deportivas"
		}.to_json

		post_company_matches(body)
		filtered_companies_list = JSON.parse(last_response.body)

		expect(filtered_companies_list["data"][0]['name']).to eq(AsesoraWithFixtures::COMPANY_NAME)
	end

	it 'searches by name when cnae is empty' do
		first_solicitude = {
			"applicantPhonenumber": AsesoraWithFixtures::APPLICANT_PHONENUMBER,
			"text": AsesoraWithFixtures::TEXT,
			"date": AsesoraWithFixtures::DATE,
			"applicantEmail": AsesoraWithFixtures::APPLICANT_EMAIL,
      'applicantId': "",
			"companyName": "First company",
			"companyCif": AsesoraWithFixtures::COMPANY_CIF_2,
			"companyCnae": AsesoraWithFixtures::COMPANY_CNAE
		}.to_json

		post_create_solicitude(first_solicitude)

		second_solicitude = {
			"applicantPhonenumber": AsesoraWithFixtures::APPLICANT_PHONENUMBER,
			"text": AsesoraWithFixtures::TEXT,
			"date": AsesoraWithFixtures::DATE,
			"applicantEmail": AsesoraWithFixtures::APPLICANT_EMAIL,
      'applicantId': "",
			"companyName": "Last company",
			"companyCif": AsesoraWithFixtures::COMPANY_CIF_3,
			"companyCnae": AsesoraWithFixtures::COMPANY_CNAE_2
		}.to_json

		post_create_solicitude(second_solicitude)

		body = {
			"name": "com",
			"cnae": ""
		}.to_json

		post_company_matches(body)
		filtered_companies_list = JSON.parse(last_response.body)

		expect(filtered_companies_list["data"].count).to be >= 2
	end

  it 'search by outdated company name return zero matches' do
    name = AsesoraWithFixtures::COMPANY_NAME
    cif = AsesoraWithFixtures::COMPANY_CIF
    employees = AsesoraWithFixtures::COMPANY_EMPLOYEES
    cnae = AsesoraWithFixtures::COMPANY_CNAE
    Companies::Service.create(name, cif, employees, cnae)

    updated_name = AsesoraWithFixtures::COMPANY_NAME_2
    updated_employees = AsesoraWithFixtures::COMPANY_EMPLOYEES_2
    Companies::Service.update(updated_name, cif, updated_employees, cnae)

    criteria = {
      name: AsesoraWithFixtures::COMPANY_NAME,
      cnae: ""
    }
    company_list = Companies::Service.all(criteria)

		expect(company_list.size).to eq(0)
  end

	private

	def post_create_solicitude(body_created)
    	post '/api/create-solicitude', body_created
	end

	def post_company_matches(filtered)
		post "/api/company-matches", filtered
	end
end
