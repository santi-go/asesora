require 'net/http'
require 'rspec'
require 'json'
require 'rack/test'
require "date"

require_relative '../asesora.rb'

describe 'Solicitude Api' do

  include Rack::Test::Methods

  def app
    Asesora
  end
  it 'returns the brand new solicitude' do
    body = {
      "applicant" => "an applicant",
      "text" => "a text",
      "date" => "2018-12-25"
    }.to_json

    post '/api/create-solicitude', body

    created_solicitude = JSON.parse(last_response.body)
    expect(created_solicitude["applicant"]).to eq("an applicant")
    expect(created_solicitude["text"]).to eq("a text")
    expect(created_solicitude["date"]).to eq("2018-12-25")
    expect(created_solicitude["creation_moment"]).not_to be_nil

  end

  it 'generate creation moment in milliseconds' do
    body = {
      "applicant" => "an applicant",
      "text" => "a text",
      "date" => ""
    }.to_json

    previous_moment = DateTime.now.strftime("%Q")

    post '/api/create-solicitude', body

    later_moment = DateTime.now.strftime("%Q")

    created_solicitude = JSON.parse(last_response.body)

    expect(created_solicitude["creation_moment"]).to be_between(previous_moment, later_moment).inclusive

  end

  it 'new solicitude has today date' do
    body = {
      "applicant" => "an applicant",
      "text" => "a text",
      "date" => ""
    }.to_json

    post '/api/create-solicitude', body


    today = Date.today.strftime("%Y-%m-%d")

    created_solicitude = JSON.parse(last_response.body)
    expect(created_solicitude["applicant"]).to eq("an applicant")
    expect(created_solicitude["text"]).to eq("a text")
    expect(created_solicitude["date"]).to eq(today)
  end
end
