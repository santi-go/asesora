require_relative '../services/solicitudes/service'
require_relative '../services/companies/service'
require_relative '../services/applicant/service'
require_relative './mergeable'

module Actions
  class RetrieveSolicitude extend Mergeable
    def self.do(id:)
      solicitude = ::Solicitudes::Service.retrieve(id)
      company = ::Companies::Service.retrieve(solicitude['company'])
      applicant = ::Applicant::Service.retrieve(solicitude['applicant'])
      prepared_solicitude = add_with_prefix(solicitude,company,'company')
      add(prepared_solicitude, applicant)
    end
  end
end
