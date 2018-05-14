require 'net/http'
require 'rspec'
require 'json'
require 'rack/test'
require "date"

require_relative '../asesora.rb'
describe 'Company Api' do

  include Rack::Test::Methods

  def app
    Asesora
  end

  it 'retrieves company if exists' do
    solicitude = {
      "name": "an applicant",
      "surname": "Dou",
      "email": "applicant@dou.com",
      "phonenumber": "123456789",
      "text" => "a text",
      "date" => "2018-12-25",
      "companyName": "Elena",
      "companyCif": "B91045948",
      "companyEmployees": "10",
      "companyCnae": "101"
    }.to_json

    post '/api/create-solicitude', solicitude

    post '/api/duplicated-company', {"id": "B91045948"}.to_json
    pepe = JSON.parse(last_response.body)
    expect(pepe["name"]).to eq("Elena")
    expect(pepe["cif"]).to eq("B91045948")
    expect(pepe["employees"]).to eq("10")
    expect(pepe["cnae"]).to eq("101")
  end

  it "knows when company is not registered yet" do
    post '/api/duplicated-company', {"id": "not_existing_cif"}.to_json
    pepe = JSON.parse(last_response.body)
    expect(pepe).to eq({})
  end

end
