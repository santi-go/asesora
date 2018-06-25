require 'rspec'
require 'json'
require 'rack/test'

require_relative './fixtures/asesora_with_fixtures'
require_relative './fixtures/fixtures'
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
			"applicantPhonenumber": Fixtures::APPLICANT_PHONENUMBER,
			"text": Fixtures::TEXT,
			"applicantemail": Fixtures::APPLICANT_EMAIL,
			"date": Fixtures::DATE,
      'applicantId': "",
			"companyName": Fixtures::COMPANY_NAME,
			"companyCif": Fixtures::COMPANY_CIF,
			"companyCnae": Fixtures::COMPANY_CNAE
		}.to_json

		post_create_solicitude(solicitude)

		body = {
			"name": "Rap",
			"cnae": "931 - Actividades deportivas"
		}.to_json

		post_company_matches(body)
		filtered_companies_list = JSON.parse(last_response.body)

		expect(filtered_companies_list["data"][0]['name']).to eq(Fixtures::COMPANY_NAME)
	end

	it 'searches by name when cnae is empty' do
		first_solicitude = {
			"applicantPhonenumber": Fixtures::APPLICANT_PHONENUMBER,
			"text": Fixtures::TEXT,
			"date": Fixtures::DATE,
			"applicantEmail": Fixtures::APPLICANT_EMAIL,
      'applicantId': "",
			"companyName": "First company",
			"companyCif": Fixtures::COMPANY_CIF_2,
			"companyCnae": Fixtures::COMPANY_CNAE
		}.to_json

		post_create_solicitude(first_solicitude)

		second_solicitude = {
			"applicantPhonenumber": Fixtures::APPLICANT_PHONENUMBER,
			"text": Fixtures::TEXT,
			"date": Fixtures::DATE,
			"applicantEmail": Fixtures::APPLICANT_EMAIL,
      'applicantId': "",
			"companyName": "Last company",
			"companyCif": Fixtures::COMPANY_CIF_3,
			"companyCnae": Fixtures::COMPANY_CNAE_2
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
    name = Fixtures::COMPANY_NAME
    cif = Fixtures::COMPANY_CIF
    employees = Fixtures::COMPANY_EMPLOYEES
    cnae = Fixtures::COMPANY_CNAE
    Companies::Service.create(name, cif, employees, cnae)

    updated_name = Fixtures::COMPANY_NAME_2
    updated_employees = Fixtures::COMPANY_EMPLOYEES_2
    Companies::Service.update(updated_name, cif, updated_employees, cnae)

    criteria = {
      name: Fixtures::COMPANY_NAME,
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
