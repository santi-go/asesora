require_relative '../services/companies/service'

module Actions
  class RetrieveCompany
    def self.do(id:)
      id = /#{id}/i
      return ::Companies::Service.create_empty if (id == "")
      ::Companies::Service.retrieve(id)
    end
  end
end
