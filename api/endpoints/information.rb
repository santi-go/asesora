require_relative '../system/actions/retrieve_navbar'

module Endpoints
  class Information
    def self.define_endpoints(api)
      api.post '/api/navbar' do
        application_information = Actions::RetrieveNavbar.do()

        application_information.to_json
      end
    end
  end
end
