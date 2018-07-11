require_relative '../system/actions/retrieve_dictionary'

module Endpoints
  class Translations
    def self.define_endpoints(api)
      api.post '/api/translations' do
        params = JSON.parse(request.body.read)

        translations = Actions::RetrieveDictionary.do(locale: params['locale'])

        {data: translations}.to_json
      end
    end
  end
end
