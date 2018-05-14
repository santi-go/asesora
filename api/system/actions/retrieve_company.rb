require_relative '../services/companies/service'

module Actions
  class RetrieveCompany
    def self.do(id:)
      ::Companies::Service.retrieve(id)
    end
  end
end
