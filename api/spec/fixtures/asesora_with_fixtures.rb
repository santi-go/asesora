require_relative '../../system/services/translation/collection'
require_relative '../../asesora'
require 'json'

require_relative './fixtures'

class AsesoraWithFixtures < Asesora
  def self.locale
    Translation::Collection::DEFAULT_LOCALE
  end

  post '/fixtures/pristine' do
    fixtures = Fixtures.new.pristine

    { 'fixtures' => fixtures }.to_json
  end

  post '/fixtures/clean' do
    Fixtures.new.clean_collections

    { 'fixtures': [] }.to_json
  end
end
