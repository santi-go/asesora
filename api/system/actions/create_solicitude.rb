require_relative '../services/solicitudes/service'

module Actions
  class CreateSolicitude
    def self.do(text:, name:, surname:, email:, phonenumber:, date:, company_name:, company_cif:, company_employees:, company_cnae:)
      ::Solicitudes::Service.create(text, name, surname, email, phonenumber, date, company_name, company_cif, company_employees, company_cnae)
    end
  end
end
