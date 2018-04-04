require_relative '../services/about/service'

module Actions
  class RetrieveAbout
    def self.do(*_)
      ::About::Service.retrieve
    end
  end
end
