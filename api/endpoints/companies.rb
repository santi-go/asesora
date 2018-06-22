require_relative '../system/actions/update_company'
require_relative '../system/actions/retrieve_solicitudes'
require_relative '../system/actions/retrieve_company'
require_relative '../system/actions/count_company_in_solicitudes'

module Endpoints
  class Companies
    def self.define_update_company(api)
      api.post '/api/update-company' do
        params = JSON.parse(request.body.read)
        data = {
            company_name: params['companyName'],
            company_cif: params['companyCif'],
            company_employees: params['companyEmployees'],
            company_cnae: params['companyCnae']
        }
        updated = Actions::UpdateCompany.do(data)
        return {}.to_json if updated.nil?
    
        updated.to_json
        end
      end

    def self.define_company_matches(api)
      api.post '/api/company-matches' do
        params = JSON.parse(request.body.read)
    
        criteria = {
          name: params['name'],
          cnae: params['cnae']
        }
        companies = Actions::RetrieveSolicitudes.do_companies(criteria)
    
        {data: companies}.to_json
      end
    end
    
    def self.define_duplicated_company(api)
      api.post '/api/duplicated-company' do
        params = JSON.parse(request.body.read)
        company = Actions::RetrieveCompany.do(id: params['id'])
        company.to_json
      end
    end

    def self.define_count_company_in_solicitudes(api)
      api.post '/api/count-company-in-solicitudes' do

        params = JSON.parse(request.body.read)
        times = Actions::CountCompanyInSolicitudes.do(cif: params['cif'])
        times.to_json
      end
    end
  end
end






