require_relative '../services/cnae/service'

module Actions
  class RetrieveCnae
    def self.do(*_)
      ::Cnae::Service.all
    end
  end
end
