require_relative '../services/solicitudes/service'
require_relative '../services/applicant/service'

module Actions
  class DeleteSolicitude
    def self.do(id:)
      solicitude = ::Solicitudes::Service.retrieve(id)
      return "500" if solicitude == {}
      applicant_id =  solicitude['applicant']
      delete_applicant_orphans(applicant_id)
      company_id =  solicitude['company']
      delete_company_orphans(company_id)
      ::Solicitudes::Service.delete(id)
    end

    private

    def self.delete_applicant_orphans(applicant_id)
      criteria_applicant = {"applicant": applicant_id}
      if only_one_solicitude_in(criteria_applicant)
        ::Applicant::Service.delete(applicant_id)
      end
    end

    def self.delete_company_orphans(company_id)
      criteria_company = {"company": company_id}
      if only_one_solicitude_in(criteria_company)
        ::Companies::Service.delete(company_id)
      end
    end

    def self.only_one_solicitude_in(criteria)
      all_solicitudes = ::Solicitudes::Service.all_by(criteria)
      return (all_solicitudes.length == 1)
    end
  end
end
