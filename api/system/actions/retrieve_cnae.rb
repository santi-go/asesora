require_relative '../services/catalogs/service'

module Actions
  class RetrieveCnae
    def self.do(*_)
      ::Catalogs::Service.cnae
    end
  end
end
