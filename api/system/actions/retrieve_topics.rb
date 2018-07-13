require_relative '../services/catalogs/service'

module Actions
  class RetrieveTopics
    def self.do(*_)
      ::Catalogs::Service.topics
    end
  end
end
