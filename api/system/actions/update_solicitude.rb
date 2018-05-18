require_relative '../services/solicitudes/service'

module Actions
  class UpdateSolicitude
    def self.do(text:, name:, surname:, email:, phonenumber:, date:, company_name:, company_cif:, company_employees:, company_cnae:, creation_moment:)
      company_id = company_cif
      ::Solicitudes::Service.update(text, name, surname, email, phonenumber, date, company_id, creation_moment)
    end
  end
end
