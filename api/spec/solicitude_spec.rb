require 'net/http'
require 'rspec'
require 'json'
require 'rack/test'
require "date"

require_relative '../asesora.rb'
require_relative './page_object/solicitudes.rb'

describe 'Solicitude Api' do

  include Rack::Test::Methods

  def app
    Asesora
  end

  context 'create solicitude' do
    it 'returns the brand new solicitude' do
      body = {
        "applicant" => {
          "name": "an applicant",
          "secondname": "Dou",
          "email": "applicant@dou.com",
          "phonenumber": "123456789"
        },
        "text" => "a text",
        "date" => "2018-12-25"
      }.to_json
      post_create_solicitude(body)

      created_solicitude = JSON.parse(last_response.body)

      expect(created_solicitude["applicant"]["name"]).to eq("an applicant")
      expect(created_solicitude["applicant"]["secondname"]).to eq("Dou")
      expect(created_solicitude["applicant"]["email"]).to eq("applicant@dou.com")
      expect(created_solicitude["applicant"]["phonenumber"]).to eq("123456789")
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
      previous_moment = DateTime.now.strftime(in_microseconds)
      post_create_solicitude(body)
      later_moment = DateTime.now.strftime(in_microseconds)

      created_solicitude = JSON.parse(last_response.body)

      expect(created_solicitude["creation_moment"]).to be_between(previous_moment, later_moment).inclusive

    end

    it 'new solicitude has today date' do
      body = {
        "applicant" => {
          "name": "an applicant",
          "secondname": "Dou",
          "email": "applicant@dou.com",
          "phonenumber": "123456789"
        },
        "text" => "a text",
        "date" => ""
      }.to_json
      post_create_solicitude(body)
      today = Date.today.strftime(in_english_format)

      created_solicitude = JSON.parse(last_response.body)

      expect(created_solicitude["applicant"]["name"]).to eq("an applicant")
      expect(created_solicitude["applicant"]["secondname"]).to eq("Dou")
      expect(created_solicitude["applicant"]["email"]).to eq("applicant@dou.com")
      expect(created_solicitude["applicant"]["phonenumber"]).to eq("123456789")
      expect(created_solicitude["text"]).to eq("a text")
      expect(created_solicitude["date"]).to eq(today)
    end
  end

  context 'retrieve solicitude' do
    it 'returns all solicitudes' do
      body = {
        "applicant" => "an applicant",
        "text" => "a text",
        "date" => ""
      }.to_json

      post '/api/retrieve-solicitudes'
      retrieved_information = JSON.parse(last_response.body)
      previous_counter = retrieved_information['data'].count

      post_create_solicitude(body)
      post_create_solicitude(body)

      post '/api/retrieve-solicitudes'
      retrieved_information = JSON.parse(last_response.body)
      actual_counter = retrieved_information['data'].count

      verification = actual_counter >= previous_counter

      expect(actual_counter - previous_counter).to eq(2)
      expect(verification).to eq(true)
    end

    it 'returns solicitudes in descendent order' do
      first_body = {
          "applicant" => "an applicant",
          "text" => "a text",
          "date" => "2050-03-20"
        }.to_json
      retrieve_first_information = post_create_solicitude(first_body)
      second_body = {
          "applicant" => "an applicant",
          "text" => "a text",
          "date" => "2050-03-20"
        }.to_json
      retrieve_second_information = post_create_solicitude(second_body)

      post '/api/retrieve-solicitudes'
      response = JSON.parse(last_response.body)
      first_solicitude = retrieve_first_date(response)
      first_creation_moment = retrieve_first_creation_moment(response)
      second_solicitude = retrieve_second_date(response)
      second_creation_moment = retrieve_second_creation_moment(response)

      creation_moment = first_creation_moment > second_creation_moment
      expect(first_solicitude).to eq("2050-03-20")
      expect(second_solicitude).to eq("2050-03-20")
      expect(creation_moment).to eq(true)
    end
  end
  context 'retrieve solicitude' do
    it 'returns one solicitude' do
      body = {
        "applicant" => {
          "name": "an applicant",
          "secondname": "Dou",
          "email": "applicant@dou.com",
          "phonenumber": "123456789"
        },
        "text" => "a text",
        "date" => "2018-12-25"
      }.to_json
      post_create_solicitude(body)

      created_solicitude = JSON.parse(last_response.body)

      id = {id: created_solicitude['creation_moment']}.to_json

      post '/api/retrieve-solicitude', id

      solicitude = JSON.parse(last_response.body)

      expect(solicitude['data']['text']).to eq(created_solicitude['text'])
      expect(solicitude['data']['date']).to eq(created_solicitude['date'])
      expect(solicitude['data']['applicant']['name']).to eq(created_solicitude['applicant']['name'])
      expect(solicitude['data']['applicant']['secondname']).to eq(created_solicitude['applicant']['secondname'])
      expect(solicitude['data']['applicant']['email']).to eq(created_solicitude['applicant']['email'])
      expect(solicitude['data']['applicant']['phonenumber']).to eq(created_solicitude['applicant']['phonenumber'])
    end
  end
end
