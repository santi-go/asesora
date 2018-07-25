require_relative '../services/solicitudes/service'
require_relative './mergeable'

module Actions
  class RetrieveSolicitudes extend Mergeable
    def self.do(*_)
      solicitudes = ::Solicitudes::Service.all
      lista = solicitudes.map do |solicitude|
        company = ::Companies::Service.retrieve(solicitude['company'], solicitude['edition_moment'])
        applicant = ::Applicant::Service.retrieve(solicitude['applicant'])
        subjects = ::Subjects::Service.all_by(solicitude['creation_moment'])

        prepared_solicitude = add_with_prefix(solicitude,company,'company')
        prepared_solicitude = add(prepared_solicitude, applicant)
        if subjects.count > 0 
          prepared_solicitude[:subjects] = subjects
        end

        prepared_solicitude
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
