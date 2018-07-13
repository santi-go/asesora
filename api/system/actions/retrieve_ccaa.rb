require_relative '../services/catalogs/service'

module Actions
  class RetrieveCcaa
    def self.do(*_)
      ::Catalogs::Service.ccaa
    end
  end
end
