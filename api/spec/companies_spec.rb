require 'rspec'
require 'json'
require 'rack/test'

require_relative './fixtures/fixtures'

describe 'Companies' do

  include Rack::Test::Methods

  def app
    Fixtures
  end

  before(:each) do
	post 'fixtures/pristine'
  end

	it 'returns a list filtered by criteria' do
		solicitude = {
			"phonenumber": Fixtures::PHONENUMBER,
			"text" => Fixtures::TEXT,
			"email" => Fixtures::EMAIL,
			"date" => Fixtures::DATE,
      'applicantId' => "",
			"companyName" => Fixtures::COMPANY_NAME,
			"companyCif" => Fixtures::COMPANY_CIF,
			"companyCnae" => Fixtures::COMPANY_CNAE
		}.to_json

		post_create_solicitude(solicitude)

		body = {
			"name" => "Com",
			"cnae" => "931 - Actividades deportivas"
		}.to_json

		post_company_matches(body)
		filtered_companies_list = JSON.parse(last_response.body)

		expect(filtered_companies_list["data"][0]['name']).to eq(Fixtures::COMPANY_NAME)
	end

	it 'searches by name when cnae is empty' do
		first_solicitude = {
			"phonenumber": Fixtures::PHONENUMBER,
			"text" => Fixtures::TEXT,
			"date" => Fixtures::DATE,
			"email" => Fixtures::EMAIL,
      'applicantId' => "",
			"companyName" => Fixtures::COMPANY_NAME,
			"companyCif" => Fixtures::COMPANY_CIF_2,
			"companyCnae" => Fixtures::COMPANY_CNAE
		}.to_json

		post_create_solicitude(first_solicitude)

		second_solicitude = {
			"phonenumber": Fixtures::PHONENUMBER,
			"text" => Fixtures::TEXT,
			"date" => Fixtures::DATE,
			"email" => Fixtures::EMAIL,
      'applicantId' => "",
			"companyName" => Fixtures::COMPANY_NAME,
			"companyCif" => Fixtures::COMPANY_CIF_3,
			"companyCnae" => Fixtures::COMPANY_CNAE_2
		}.to_json

		post_create_solicitude(second_solicitude)

		body = {
			"name" => "Com",
			"cnae" => ""
		}.to_json

		post_company_matches(body)
		filtered_companies_list = JSON.parse(last_response.body)

		expect(filtered_companies_list["data"].count).to be >= 2
	end

	private

	def post_create_solicitude(body_created)
    	post '/api/create-solicitude', body_created
	end

	def post_company_matches(filtered)
		post "/api/company-matches", filtered
	end
end
