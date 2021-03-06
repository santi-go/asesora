require_relative '../services/solicitudes/service'
require_relative '../services/companies/service'
require_relative '../services/applicant/service'


module Actions
  class CreateSolicitude
    def self.do(date:, text:, source:, name:, surname:, email:, phonenumber:, ccaa:, id:, company_name:, company_cif:, company_employees:, company_cnae:)
      if ( id == "" )
        applicant = create_applicant(name, surname, email, phonenumber, ccaa)
      else
        applicant = retrieve_applicant(name, surname, email, phonenumber, ccaa, id)
      end
      company = create_company(company_name, company_cif, company_employees, company_cnae)
      solicitude = create_solicitude(date, text, source, applicant, company)
      solicitude
    end

    private

    def self.create_applicant(name, surname, email, phonenumber, ccaa)
      ::Applicant::Service.create(
        name,
        surname,
        email,
        phonenumber,
        ccaa
      )
    end

    def self.retrieve_applicant(name, surname, email, phonenumber, ccaa, id)
      ::Applicant::Service.retrieve_with_id(
        name,
        surname,
        email,
        phonenumber,
        ccaa,
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

    def self.create_solicitude(date, text, source, applicant, company)
      company_id = company["cif"]
      applicant_id = applicant["id"]

      ::Solicitudes::Service.create(
        date,
        text,
        source,
        applicant_id,
        company_id
      )
    end
  end
end
