require_relative '../system/actions/create_solicitude'
require_relative '../system/actions/retrieve_solicitude'
require_relative '../system/actions/retrieve_solicitudes'
require_relative '../system/actions/update_solicitude'
require_relative '../system/actions/delete_solicitude'
require_relative '../system/actions/retrieve_cnae'
require_relative '../system/actions/create_subject'
require_relative '../system/actions/retrieve_subjects'
require_relative '../system/actions/retrieve_subjects'
require_relative '../system/actions/retrieve_topics'


module Endpoints
  class Solicitudes
    def self.define_create_solicitude(api) 
      api.post '/api/create-solicitude' do
        params = JSON.parse(request.body.read)
        data = {
          text:params['text'],
          name:params['applicantName'],
          surname:params['applicantSurname'],
          email:params['applicantEmail'],
          id:params['applicantId'],
          phonenumber:params['applicantPhonenumber'],
          date:params['date'],
          company_name:params['companyName'],
          company_cif:params['companyCif'],
          company_employees:params['companyEmployees'],
          company_cnae:params['companyCnae']
        }
    
        created = Actions::CreateSolicitude.do(data)
        created.to_json
      end
    end

    def self.define_retrieve_solicitude(api)
      api.post '/api/retrieve-solicitude' do
        params = JSON.parse(request.body.read)
    
        solicitude = Actions::RetrieveSolicitude.do(id: params['id'])
    
        {data: solicitude}.to_json
      end
    end
    
    def self.define_retrieve_solicitudes(api)
      api.post '/api/retrieve-solicitudes' do
        retrieve_solicitudes = Actions::RetrieveSolicitudes.do()
    
        list_solicitudes = retrieve_solicitudes
    
        {data: list_solicitudes}.to_json
      end
    end

    def self.define_update_solicitude(api)
      api.post '/api/update-solicitude' do
        params = JSON.parse(request.body.read)
        data = {
          date:params['date'],
          text:params['text'],
          id:params['applicantId'],
          company_cif:params['companyCif'],
          creation_moment:params['creation_moment']
        }
    
        updated = Actions::UpdateSolicitude.do(data)
        return {}.to_json if updated.nil?
        updated.to_json
      end
    end

    def self.define_delete_solicitude(api)
      api.post '/api/delete-solicitude' do
        params = JSON.parse(request.body.read)
    
        response = Actions::DeleteSolicitude.do(id: params['id'])
        return status 500 if response == "500"
        status 200
      end
    end

    def self.define_retrieve_cnae(api)
      api.post '/api/cnae' do
        cnae_catalog = Actions::RetrieveCnae.do()
        
        {data: cnae_catalog}.to_json
      end
    end

    def self.define_create_subject(api)
      api.post '/api/create-subject' do
        params = JSON.parse(request.body.read)
      
        data = {
          solicitude_id: params['solicitudeId'],
          proposal: params['proposal'],
          analysis: params['analysis'],
          topics: params['topics']
        }
      
        solicitude_subject = Actions::CreateSubject.do(data)
      
        solicitude_subject.to_json
      end
    end

    def self.define_retrieve_subjects(api)
      api.post '/api/retrieve-subjects' do
        params = JSON.parse(request.body.read)
      
        subjects = Actions::RetrieveSubjects.do(solicitude_id: params['solicitudeId'])
      
        {data: subjects}.to_json
      end
    end

    def self.define_retrieve_topics(api)
      api.post '/api/topics' do
        topics_catalog = Actions::RetrieveTopics.do()
        {data: topics_catalog}.to_json
      end
    end
  end
end


