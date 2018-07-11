require_relative '../services/close_reasons/service'

module Actions
  class RetrieveCloseReasons
    def self.do(*_)
      ::CloseReasons::Service.all
    end
  end
end
