require_relative '../services/companies/service'

module Actions
  class UpdateCompany
    def self.do(company_name:, company_cif:, company_employees:, company_cnae:)
      ::Companies::Service.update(company_name, company_cif, company_employees, company_cnae)
    end
  end
end