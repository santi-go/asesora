require 'json'
require 'rack/test'

require_relative '../asesora.rb'
require_relative './fixtures'

describe 'Translations' do

  include Rack::Test::Methods

  def app
    Asesora
  end

  it 'retrieve all translations for a locale' do
    body = {
      "locale" => Fixture.locale
    }.to_json

    post '/api/translations', body

    retrieved_dictionary = JSON.parse(last_response.body)
    expect(retrieved_dictionary["data"]).not_to be_nil
  end
end
