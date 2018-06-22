require_relative './fixtures/fixtures'
require 'rspec'
require 'rack/test'

describe 'Staging rack' do
  include Rack::Test::Methods

  def app
    Fixtures
  end

  it 'clean database and creates three solicitudes' do
    post 'fixtures/staging_pristine'
  end
end
