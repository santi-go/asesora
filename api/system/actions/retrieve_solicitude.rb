require_relative '../services/solicitudes/service'
require_relative '../services/companies/service'
require_relative '../services/applicant/service'
require_relative './mergeable'

module Actions
  class RetrieveSolicitude extend Mergeable
    def self.do(id:)
      solicitude = ::Solicitudes::Service.retrieve(id)
      return {} if solicitude.empty?
      company = ::Companies::Service.retrieve(solicitude['company'], solicitude['edition_moment'])
      applicant = ::Applicant::Service.retrieve(solicitude['applicant'])
      subjects = ::Subjects::Service.all_by(id)
      prepared_solicitude = add_with_prefix(solicitude,company,'company')
      prepared_applicant = add_with_prefix(solicitude,applicant,'applicant')
      solicitude = add(prepared_solicitude, prepared_applicant)
      solicitude[:subjects] = subjects

      solicitude
    end
  end
end
