require_relative '../services/catalogs/service'

module Actions
  class RetrieveCloseReasons
    def self.do(*_)
      ::Catalogs::Service.close_reasons
    end
  end
end
