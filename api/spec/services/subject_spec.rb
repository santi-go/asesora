require 'json'

require_relative  '../../system/services/subjects/service'
require_relative  '../../system/domain/subject'
require_relative './../fixtures/asesora_with_fixtures'
require_relative './../fixtures/fixtures'

describe 'Subject service' do
  include Rack::Test::Methods

  def app
    AsesoraWithFixtures
  end

  after(:each) do
    post 'fixtures/clean'
  end

  it "retrieve subject" do
    solicitude_id = Fixtures::CREATION_MOMENT
    proposal = Fixtures::PROPOSAL
    description = Fixtures::DESCRIPTION
    analysis = Fixtures::ANALYSIS
    topics = Fixtures::TOPICS

    subject = Subjects::Service.create(solicitude_id, proposal, description,analysis, topics)
    result = Subjects::Service.retrieve(subject["id"])

    expect(result["solicitude_id"]).to eq(solicitude_id)
  end
end
