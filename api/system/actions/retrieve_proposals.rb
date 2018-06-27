require_relative '../services/proposals/service'

module Actions
  class RetrieveProposals
    def self.do(*_)
      ::Proposals::Service.all
    end
  end
end
