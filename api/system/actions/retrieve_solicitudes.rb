require_relative '../services/solicitudes/service'

module Actions
  class RetrieveSolicitudes
    def self.do(*_)
      solicitudes = ::Solicitudes::Service.all
      solicitudes.map do |solicitude|
        company = ::Companies::Service.retrieve(solicitude['company'])
        applicant = ::Applicant::Service.retrieve(solicitude['applicant'])
        add_with_prefix(solicitude,company,'company')
        add(solicitude, applicant)
      end
    end

    def self.do_companies(companies)
      ::Companies::Service.all(companies)
    end

    def self.do_applicants(applicants)
      ::Applicant::Service.all(applicants)
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
