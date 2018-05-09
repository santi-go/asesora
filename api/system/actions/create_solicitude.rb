require_relative '../services/solicitudes/service'
require_relative '../services/companies/service'

module Actions
  class CreateSolicitude
    def self.do(text:, name:, surname:, email:, phonenumber:, date:, company_name:, company_cif:, company_employees:, company_cnae:)
      company = ::Companies::Service.create(company_name, company_cif, company_employees, company_cnae)
      result = ::Solicitudes::Service.create(text, name, surname, email, phonenumber, date, company.identify())
      result
    end
  end
end
