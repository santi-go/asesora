require 'rspec'
require 'json'
require 'rack/test'

require_relative './fixtures/asesora_with_fixtures'
require_relative './fixtures/fixtures'

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
            "solicitudeId": Fixtures::CREATION_MOMENT,
            "proposal": Fixtures::PROPOSAL,
            "analysis": Fixtures::ANALYSIS,
            "topics": Fixtures::TOPICS
		}.to_json

        post '/api/create-subject', subject
		    response = JSON.parse(last_response.body)

        expect(response["proposal"]).to eq(Fixtures::PROPOSAL)
        expect(response["solicitude_id"]).to eq(Fixtures::CREATION_MOMENT)
  end

  it 'retrieves subjects by creation moment of the solicitude' do
    created_subject = {
      "solicitudeId": Fixtures::CREATION_MOMENT,
      "proposal": Fixtures::PROPOSAL,
      "analysis": Fixtures::ANALYSIS,
      "topics": Fixtures::TOPICS
    }.to_json

    post '/api/create-subject', created_subject

    retrieve_subject = {
            "solicitudeId": Fixtures::CREATION_MOMENT
    }.to_json

    post '/api/retrieve-subjects', retrieve_subject
    response = JSON.parse(last_response.body)

    expect(response["data"][0]["proposal"]).to eq(Fixtures::PROPOSAL)
    expect(response["data"][0]["solicitude_id"]).to eq(Fixtures::CREATION_MOMENT)
	end

  it 'updates subject' do
		subject = {
            "solicitudeId": Fixtures::CREATION_MOMENT,
            "proposal": Fixtures::PROPOSAL,
            "analysis": Fixtures::ANALYSIS,
            "topics": Fixtures::TOPICS
		}.to_json

    post '/api/create-subject', subject
    response = JSON.parse(last_response.body)

    other_subject = {
            "subjectId": response['id'],
            "proposal": Fixtures::PROPOSAL_2,
            "analysis": Fixtures::ANALYSIS_2,
            "topics": Fixtures::TOPICS
		}.to_json

    post '/api/update-subject', other_subject
    updated_response = JSON.parse(last_response.body)


    expect(updated_response["proposal"]).to eq(Fixtures::PROPOSAL_2)
    expect(updated_response["analysis"]).to eq(Fixtures::ANALYSIS_2)
    expect(updated_response["topics"]).to eq(Fixtures::TOPICS)
  end
end
