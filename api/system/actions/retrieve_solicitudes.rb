require_relative '../services/solicitudes/service'
require_relative './mergeable'

module Actions
  class RetrieveSolicitudes extend Mergeable
    def self.do(*_)
      solicitudes = ::Solicitudes::Service.all
      lista = solicitudes.map do |solicitude|
        company = ::Companies::Service.retrieve(solicitude['company'], solicitude['edition_moment'])
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
  end
end
