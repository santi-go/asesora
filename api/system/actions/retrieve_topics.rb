require_relative '../services/topics/service'

module Actions
  class RetrieveTopics
    def self.do(*_)
      ::Topics::Service.all
    end
  end
end
