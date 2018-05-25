require_relative '../services/solicitudes/service'
require_relative '../services/companies/service'
require_relative '../services/applicant/service'


module Actions
  class RetrieveSolicitude
    def self.do(id:)
      solicitude = ::Solicitudes::Service.retrieve(id)
      company = ::Companies::Service.retrieve(solicitude['company'])
      applicant = ::Applicant::Service.retrieve(solicitude['applicant'])
      prepared_solicitude = add_with_prefix(solicitude,company,'company')
      add(prepared_solicitude, applicant)
    end

    def self.add_with_prefix(base, added, prefix)
        prefixed = prefix(added,prefix)
        add(base,prefixed)
    end

    def self.prefix(base, prefix)
        prefixed = {}
        base.each {|key,value|
          prefixed[prefix+'_'+key] = value
        }
        prefixed
    end

    def self.add(base,added)
      base.merge(added)
    end
  end
end
