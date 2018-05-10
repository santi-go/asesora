require_relative '../services/companies/service'

module Actions
  class RetrieveCompany
    def self.do(id:)
      company = ::Companies::Service.retrieve(id)
      prefix(company,'company')
    end

    def self.prefix(base, prefix)
        prefixed = {}
        base.each {|key,value|
          prefixed[prefix+'_'+key] = value
        }
        prefixed
    end
  end
end
