require_relative '../services/solicitudes/service'
require_relative '../services/companies/service'

module Actions
  class CreateSolicitude
    def self.do(text:, name:, surname:, email:, phonenumber:, date:, company_name:, company_cif:, company_employees:, company_cnae:)
      company = create_company(company_name, company_cif, company_employees, company_cnae)
      solicitude = create_solicitude(text, name, surname, email, phonenumber, date, company)

      solicitude
    end

    private

    def self.create_company(name, cif, employees, cnae)
      ::Companies::Service.create(
        name,
        cif,
        employees,
        cnae
      )
    end

    def self.create_solicitude(text, name, surname, email, phonenumber, date, company)
      company_id = identify(company)

      ::Solicitudes::Service.create(
        text,
        name,
        surname,
        email,
        phonenumber,
        date,
        company_id
      )
    end

    def self.identify(company)
      company.identify()
    end
  end
end
