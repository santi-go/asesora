require_relative '../services/translation/service'

module Actions
  class RetrieveDictionary
    def self.do(locale:)
      ::Translation::Service.retrieve(locale)
    end
  end
end
