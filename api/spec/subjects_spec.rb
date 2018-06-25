require 'rspec'
require 'json'
require 'rack/test'

require_relative './fixtures/asesora_with_fixtures'

describe 'Subjects Api' do

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

	it 'create subjects for solicitude' do
		subject = {
            "solicitudeId": AsesoraWithFixtures::CREATION_MOMENT,
            "proposal": AsesoraWithFixtures::PROPOSAL,
            "analysis": AsesoraWithFixtures::ANALYSIS,
            "topics": AsesoraWithFixtures::TOPICS
		}.to_json

        post '/api/create-subject', subject
		    response = JSON.parse(last_response.body)

        expect(response["proposal"]).to eq(AsesoraWithFixtures::PROPOSAL)
        expect(response["solicitude_id"]).to eq(AsesoraWithFixtures::CREATION_MOMENT)
  end

  it 'retrieves subjects by creation moment of the solicitude' do
    created_subject = {
      "solicitudeId": AsesoraWithFixtures::CREATION_MOMENT,
      "proposal": AsesoraWithFixtures::PROPOSAL,
      "analysis": AsesoraWithFixtures::ANALYSIS,
      "topics": AsesoraWithFixtures::TOPICS
    }.to_json

    post '/api/create-subject', created_subject

    retrieve_subject = {
            "solicitudeId": AsesoraWithFixtures::CREATION_MOMENT
    }.to_json

    post '/api/retrieve-subjects', retrieve_subject
    response = JSON.parse(last_response.body)

    expect(response["data"][0]["proposal"]).to eq(AsesoraWithFixtures::PROPOSAL)
    expect(response["data"][0]["solicitude_id"]).to eq(AsesoraWithFixtures::CREATION_MOMENT)
	end
end
