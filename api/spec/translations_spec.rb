require 'json'
require 'rack/test'

require_relative './fixtures/asesora_with_fixtures'

describe 'Translations' do

  include Rack::Test::Methods

  def app
    AsesoraWithFixtures
  end

  it 'retrieve all translations for a locale' do
    body = {
      "locale" => AsesoraWithFixtures.locale
    }.to_json

    post '/api/translations', body

    retrieved_dictionary = JSON.parse(last_response.body)
    expect(retrieved_dictionary["data"]).not_to be_nil
  end
end
