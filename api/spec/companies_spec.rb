require 'rspec'
require 'json'
require 'rack/test'

require_relative '../asesora.rb'

describe 'Companies' do

  include Rack::Test::Methods

  def app
    Asesora
  end
 
	it 'returns a list filtered by criteria' do
		solicitude = {
			"phonenumber": "123456789",
			"text" => "a text",
			"date" => "2018-12-25",
			"companyName" => "an applicant",
			"companyCif" => "26751998P",
			"companyCnae" => "931 - Actividades deportivas"
		}.to_json

		post_create_solicitude(solicitude)

		body = {
			"name" => "an a",
			"cnae" => "931 - Actividades deportivas"
		}.to_json
		
		post_company_matches(body)
		filtered_companies_list = JSON.parse(last_response.body)

		expect(filtered_companies_list["data"][0]["name"]).to eq("an applicant")
	end

	it 'searches by name when cnae is empty' do
		first_solicitude = {
			"phonenumber": "123456789",
			"text" => "a text",
			"date" => "2018-12-25",
			"companyName" => "an applicant",
			"companyCif" => "26751998P",
			"companyCnae" => "931 - Actividades deportivas"
		}.to_json

		post_create_solicitude(first_solicitude)

		second_solicitude = {
			"phonenumber": "123456789",
			"text" => "a text",
			"date" => "2018-12-25",
			"companyName" => "an applicant",
			"companyCif" => "26751998P",
			"companyCnae" => "870 - Asistencia en establecimientos residenciales"
		}.to_json

		post_create_solicitude(second_solicitude)

		body = {
			"name" => "an a",
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