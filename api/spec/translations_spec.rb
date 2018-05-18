require 'json'
require 'rack/test'

require_relative './fixtures/fixtures'

describe 'Translations' do

  include Rack::Test::Methods

  def app
    Fixtures
  end

  it 'retrieve all translations for a locale' do
    body = {
      "locale" => Fixtures.locale
    }.to_json

    post '/api/translations', body

    retrieved_dictionary = JSON.parse(last_response.body)
    expect(retrieved_dictionary["data"]).not_to be_nil
  end
end
