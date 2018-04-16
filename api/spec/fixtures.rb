require_relative '../system/services/translation/collection'

class Fixture
  def self.locale
    Translation::Collection::DEFAULT_LOCALE
  end
end
