require_relative '../services/translation/service'

module Actions
  class RetrieveTranslations
    def self.do(locale:)
      ::Translation::Service.retrieve(locale)
    end
  end
end
