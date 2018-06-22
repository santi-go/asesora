require_relative '../system/actions/retrieve_about'

module Endpoints
  class Information
    def self.define_retrieve_about(api)
      api.post '/api/about' do
        application_information = Actions::RetrieveAbout.do()
    
        application_information.to_json
      end
    end
  end
end
