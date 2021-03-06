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
            "description": Fixtures::DESCRIPTION,
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
      "description": Fixtures::DESCRIPTION,
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
    expect(response["data"][0]["description"]).to eq(Fixtures::DESCRIPTION)
    expect(response["data"][0]["solicitude_id"]).to eq(Fixtures::CREATION_MOMENT)
	end

  it 'updates subject' do
		subject = {
            "solicitudeId": Fixtures::CREATION_MOMENT,
            "proposal": Fixtures::PROPOSAL,
            "description": Fixtures::DESCRIPTION,
            "analysis": Fixtures::ANALYSIS,
            "topics": Fixtures::TOPICS
		}.to_json

    post '/api/create-subject', subject
    response = JSON.parse(last_response.body)

    other_subject = {
            "subjectId": response['id'],
            "proposal": Fixtures::PROPOSAL_2,
            "description": Fixtures::DESCRIPTION_2,
            "analysis": Fixtures::ANALYSIS_2,
            "topics": Fixtures::TOPICS
		}.to_json

    post '/api/update-subject', other_subject
    updated_response = JSON.parse(last_response.body)


    expect(updated_response["proposal"]).to eq(Fixtures::PROPOSAL_2)
    expect(updated_response["description"]).to eq(Fixtures::DESCRIPTION_2)
    expect(updated_response["analysis"]).to eq(Fixtures::ANALYSIS_2)
    expect(updated_response["topics"]).to eq(Fixtures::TOPICS)
  end

  it 'allows to add closing moment' do
    subject = {
            "solicitudeId": Fixtures::CREATION_MOMENT,
            "proposal": Fixtures::PROPOSAL,
            "description": Fixtures::DESCRIPTION,
            "analysis": Fixtures::ANALYSIS,
            "topics": Fixtures::TOPICS
		}.to_json

    post '/api/create-subject', subject
    response = JSON.parse(last_response.body)

    expect(response["closed"]).to eq(nil)

    closing_subject = {
            "solicitudeId": Fixtures::CREATION_MOMENT,
            "subjectId": response['id'],
            "proposal": Fixtures::PROPOSAL,
            "description": Fixtures::DESCRIPTION,
            "analysis": Fixtures::ANALYSIS,
            "topics": Fixtures::TOPICS,
            "reason": "A reason",
            "comments": "A comment"
		}.to_json

    post '/api/close-subject', closing_subject
    closed_response = JSON.parse(last_response.body)
    expect(closed_response["reason"]).to eq("A reason")
    expect(closed_response["comments"]).to eq("A comment")
    expect(closed_response["closed"]).not_to eq(nil)
  end

  it 'allows to create and close subject at the moment' do
    closing_subject = {
      "subjectId": "",
      "solicitudeId": Fixtures::CREATION_MOMENT,
      "proposal": Fixtures::PROPOSAL,
      "description": Fixtures::DESCRIPTION,
      "analysis": Fixtures::ANALYSIS,
      "topics": Fixtures::TOPICS,
      "reason": "A reason",
      "comments": "A comment"
    }.to_json

    post '/api/close-subject', closing_subject
    closed_response = JSON.parse(last_response.body)

    expect(closed_response["id"]).not_to eq(nil)
    expect(closed_response["reason"]).to eq("A reason")
    expect(closed_response["comments"]).to eq("A comment")
    expect(closed_response["closed"]).not_to eq(nil)
  end

  it 'not allows close two times' do
    subject = {
            "solicitudeId": Fixtures::CREATION_MOMENT,
            "proposal": Fixtures::PROPOSAL,
            "description": Fixtures::DESCRIPTION,
            "analysis": Fixtures::ANALYSIS,
            "topics": Fixtures::TOPICS
		}.to_json

    post '/api/create-subject', subject
    response = JSON.parse(last_response.body)

    closing_subject_1 = {
            "solicitudeId": Fixtures::CREATION_MOMENT,
            "subjectId": response['id'],
            "proposal": Fixtures::PROPOSAL,
            "description": Fixtures::DESCRIPTION,
            "analysis": Fixtures::ANALYSIS,
            "topics": Fixtures::TOPICS,
            "reason": "A reason",
            "comments": "A comment"
		}.to_json

    post '/api/close-subject', closing_subject_1
    closed_response_1 = JSON.parse(last_response.body)

    closed_1 = closed_response_1['closed']

    closing_subject_2 = {
            "solicitudeId": Fixtures::CREATION_MOMENT,
            "subjectId": response['id'],
            "proposal": Fixtures::PROPOSAL,
            "description": Fixtures::DESCRIPTION,
            "analysis": Fixtures::ANALYSIS,
            "topics": Fixtures::TOPICS,
            "reason": "A reason",
            "comments": "A comment",
            "closed": closed_1
		}.to_json

    post '/api/close-subject', closing_subject_2
    closed_response_2 = JSON.parse(last_response.body)

    closed_2 = closed_response_2['closed']

    expect(closed_1).to eq(closed_2)
  end

  it 'delete subject' do
		a_subject = {
            "solicitudeId": Fixtures::CREATION_MOMENT,
            "proposal": Fixtures::PROPOSAL,
            "description": Fixtures::DESCRIPTION,
            "analysis": Fixtures::ANALYSIS,
            "topics": Fixtures::TOPICS
		}.to_json

    other_subject = {
            "solicitudeId": Fixtures::CREATION_MOMENT,
            "proposal": Fixtures::PROPOSAL_2,
            "description": Fixtures::DESCRIPTION_2,
            "analysis": Fixtures::ANALYSIS_2,
            "topics": Fixtures::TOPICS_2
		}.to_json

    post '/api/create-subject', a_subject

    post '/api/create-subject', other_subject
    response = JSON.parse(last_response.body)
    subject_id = response["id"]

    retrieve_subject = {
      "solicitudeId": Fixtures::CREATION_MOMENT
    }.to_json

    post '/api/retrieve-subjects', retrieve_subject
    response = JSON.parse(last_response.body)
    subjects_before_remove = response["data"].count

    subject_for_delete = {
      "solicitudeId": Fixtures::CREATION_MOMENT,
      "subjectId": subject_id
    }.to_json

    post '/api/delete-subject', subject_for_delete

    post '/api/retrieve-subjects', retrieve_subject
    response = JSON.parse(last_response.body)
    subjects_after_remove = response["data"].count

    is_deleted = subjects_before_remove > subjects_after_remove
    expect(is_deleted).to be(true)
  end

  it 'delete subject return error 500 when subject not exist ' do
    subject_inexitent = "0"
    subject_for_delete = {
      "solicitudeId": Fixtures::CREATION_MOMENT,
      "subjectId": subject_inexitent
    }.to_json

    post '/api/delete-subject', subject_for_delete
    response = last_response.status

    expect(response).to eq(500)
  end
end
