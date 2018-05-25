require_relative '../services/solicitudes/service'

module Actions
  class RetrieveSolicitudes
    def self.do(*_)
      solicitudes = ::Solicitudes::Service.all
      lista = solicitudes.map do |solicitude|
        company = ::Companies::Service.retrieve(solicitude['company'])
        applicant = ::Applicant::Service.retrieve(solicitude['applicant'])
        prepared_solicitude = add_with_prefix(solicitude,company,'company')
        add(prepared_solicitude, applicant)
      end
    end

    def self.do_companies(companies)
      ::Companies::Service.all(companies)
    end

    def self.do_applicants(criteria)
      ::Applicant::Service.all_by(criteria)
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
