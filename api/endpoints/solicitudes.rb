require_relative '../system/actions/create_solicitude'
require_relative '../system/actions/retrieve_solicitude'
require_relative '../system/actions/retrieve_solicitudes'
require_relative '../system/actions/update_solicitude'
require_relative '../system/actions/delete_solicitude'
require_relative '../system/actions/retrieve_cnae'
require_relative '../system/actions/retrieve_ccaa'
require_relative '../system/actions/retrieve_close_reasons'
require_relative '../system/actions/create_subject'
require_relative '../system/actions/update_subject'
require_relative '../system/actions/close_subject'
require_relative '../system/actions/retrieve_subjects'
require_relative '../system/actions/retrieve_topics'
require_relative '../system/actions/retrieve_proposals'
require_relative '../system/actions/retrieve_source_formats'
require_relative '../system/actions/delete_subject'

module Endpoints
  class Solicitudes
    def self.define_endpoints(api)
      api.post '/api/create-solicitude' do
        params = JSON.parse(request.body.read)
        data = {
          text:params['text'],
          name:params['applicantName'],
          surname:params['applicantSurname'],
          email:params['applicantEmail'],
          phonenumber:params['applicantPhonenumber'],
          ccaa:params['applicantCcaa'],
          id:params['applicantId'],
          date:params['date'],
          source:params['source'],
          company_name:params['companyName'],
          company_cif:params['companyCif'],
          company_employees:params['companyEmployees'],
          company_cnae:params['companyCnae']
        }

        created = Actions::CreateSolicitude.do(data)
        created.to_json
      end

      api.post '/api/retrieve-solicitude' do
        params = JSON.parse(request.body.read)

        solicitude = Actions::RetrieveSolicitude.do(id: params['id'])

        {data: solicitude}.to_json
      end

      api.post '/api/retrieve-solicitudes' do
        retrieve_solicitudes = Actions::RetrieveSolicitudes.do()

        list_solicitudes = retrieve_solicitudes

        {data: list_solicitudes}.to_json
      end

      api.post '/api/update-solicitude' do
        params = JSON.parse(request.body.read)
        data = {
          date:params['date'],
          text:params['text'],
          source:params['source'],
          id:params['applicantId'],
          company_cif:params['companyCif'],
          creation_moment:params['creation_moment']
        }

        updated = Actions::UpdateSolicitude.do(data)
        return {}.to_json if updated.nil?
        updated.to_json
      end

      api.post '/api/delete-solicitude' do
        params = JSON.parse(request.body.read)

        response = Actions::DeleteSolicitude.do(id: params['id'])
        return status 500 if response == "500"
        status 200
      end

      api.post '/api/cnae' do
        cnae_catalog = Actions::RetrieveCnae.do()

        {data: cnae_catalog}.to_json
      end

      api.post '/api/ccaa' do
        ccaa_catalog = Actions::RetrieveCcaa.do()

        {data: ccaa_catalog}.to_json
      end

      api.post '/api/source_formats' do
        source_formats_catalog = Actions::RetrieveSourceFormats.do()

        {data: source_formats_catalog}.to_json
      end

      api.post '/api/close-reasons' do
        close_reasons_catalog = Actions::RetrieveCloseReasons.do()

        {data: close_reasons_catalog}.to_json
      end

      api.post '/api/create-subject' do
        params = JSON.parse(request.body.read)

        data = {
          solicitude_id: params['solicitudeId'],
          proposal: params['proposal'],
          description: params['description'],
          analysis: params['analysis'],
          topics: params['topics']
        }

        solicitude_subject = Actions::CreateSubject.do(data)

        solicitude_subject.to_json
      end

      api.post '/api/update-subject' do
        params = JSON.parse(request.body.read)
        data = {
          id: params['subjectId'],
          solicitude_id: params['solicitudeId'],
          proposal: params['proposal'],
          description: params['description'],
          analysis: params['analysis'],
          topics: params['topics']
        }

        updated = Actions::UpdateSubject.do(data)
        return {}.to_json if updated.nil?
        updated.to_json
      end

      api.post '/api/close-subject' do
        params = JSON.parse(request.body.read)

        data = {
          solicitude_id: params['solicitudeId'],
          id: params['subjectId'],
          proposal: params['proposal'],
          description: params['description'],
          analysis: params['analysis'],
          topics: params['topics'],
          reason: params['reason'],
          comments: params['comments'],
          closed: params['closed']
        }

        updated = Actions::CloseSubject.do(data)

        return {}.to_json if updated.nil?
        updated.to_json
      end

      api.post '/api/retrieve-subjects' do
        params = JSON.parse(request.body.read)

        subjects = Actions::RetrieveSubjects.do(solicitude_id: params['solicitudeId'])

        {data: subjects}.to_json
      end

      api.post '/api/delete-subject' do
        params = JSON.parse(request.body.read)

        response = Actions::DeleteSubject.do(id: params['subjectId'])
        return status 500 if response == "500"
        status 200
        {data: {id: params['subjectId']}}.to_json
      end

      api.post '/api/topics' do
        topics_catalog = Actions::RetrieveTopics.do()
        {data: topics_catalog}.to_json
      end

      api.post '/api/proposals' do
        proposals_catalog = Actions::RetrieveProposals.do()
        {data: proposals_catalog}.to_json
      end
    end
  end
end
