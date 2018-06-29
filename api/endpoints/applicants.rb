require_relative '../system/actions/update_applicant'
require_relative '../system/actions/retrieve_solicitudes'

module Endpoints
  class Applicants
    def self.define_update_applicant(api)
      api.post '/api/update-applicant' do
        params = JSON.parse(request.body.read)
        data = {
          name:params['applicantName'],
          surname:params['applicantSurname'],
          email:params['applicantEmail'],
          phonenumber:params['applicantPhonenumber'],
          id:params['applicantId']
        }
    
        updated = Actions::UpdateApplicant.do(data)
        return {}.to_json if updated.nil?
    
        updated.to_json
      end
    end

    def self.define_search_applicants(api)
      api.post '/api/applicant-matches' do
        params = JSON.parse(request.body.read)
    
        criteria = {
          name: params['applicantName'],
          surname: params['applicantSurname'],
          phonenumber: params['applicantPhonenumber'],
          email: params['applicantEmail']
        }
    
        applicants = Actions::RetrieveSolicitudes.do_applicants(criteria)
        {data: applicants}.to_json
      end
    end
  end
end
