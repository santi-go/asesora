require_relative '../services/solicitudes/service'
require_relative '../services/companies/service'
require_relative '../services/applicant/service'


module Actions
  class CreateSolicitude
    def self.do(date:, text:, name:, surname:, email:, phonenumber:, id:, company_name:, company_cif:, company_employees:, company_cnae:)
      if ( id == "" )
        applicant = create_applicant(name, surname, email, phonenumber)
      else
        applicant = retrieve_applicant(name, surname, email, phonenumber, id)
      end

      company = create_company(company_name, company_cif, company_employees, company_cnae)
      solicitude = create_solicitude(date, text, applicant, company)

      solicitude
    end

    private

    def self.create_applicant(name, surname, email, phonenumber)
      ::Applicant::Service.create(
        name,
        surname,
        email,
        phonenumber
      )
    end

    def self.retrieve_applicant(name, surname, email, phonenumber, id)
      ::Applicant::Service.retrieve_with_id(
        name,
        surname,
        email,
        phonenumber,
        id
      )
    end

    def self.create_company(name, cif, employees, cnae)
      ::Companies::Service.create(
        name,
        cif,
        employees,
        cnae
      )
    end

    def self.create_solicitude(date, text, applicant, company)
      company_id = identify(company)
      applicant_id = identify(applicant)

      ::Solicitudes::Service.create(
        date,
        text,
        applicant_id,
        company_id
      )
    end

    def self.identify(entity)
      entity.identify()
    end
  end
end
