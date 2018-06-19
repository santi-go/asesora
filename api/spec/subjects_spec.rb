require 'rspec'
require 'json'
require 'rack/test'

require_relative './fixtures/fixtures'

describe 'Subjects Api' do

  include Rack::Test::Methods

  def app
    Fixtures
  end

  before(:each) do
	  post 'fixtures/pristine'
  end

  after(:each) do
    post 'fixtures/clean'
  end

	it 'create subjects for solicitude' do
		subject = {
            "creation_moment": Fixtures::CREATION_MOMENT,
            "proposal": Fixtures::PROPOSAL,
            "analysis": Fixtures::ANALYSIS,
            "topics": Fixtures::TOPICS
		}.to_json

        post '/api/create-subject', subject
		p response = JSON.parse(last_response.body)

        expect(response["proposal"]).to eq(Fixtures::PROPOSAL)
        expect(response["solicitude_id"]).to eq(Fixtures::CREATION_MOMENT)
	end
end
