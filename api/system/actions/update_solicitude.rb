require_relative '../services/solicitudes/service'

module Actions
  class UpdateSolicitude
    def self.do(text:, name:, surname:, email:, phonenumber:, date:, company_name:, company_cif:, company_employees:, company_cnae:, creation_moment:)
      company_id = company_cif
      applicant_id = email + phonenumber
      ::Solicitudes::Service.update(date, text, applicant_id, company_id, creation_moment)
    end
  end
end
