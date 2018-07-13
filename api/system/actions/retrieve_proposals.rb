require_relative '../services/catalogs/service'

module Actions
  class RetrieveProposals
    def self.do(*_)
      ::Catalogs::Service.proposals
    end
  end
end
