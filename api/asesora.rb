require 'sinatra/base'
require 'sinatra/cross_origin'
require 'json'

require_relative 'system/actions/factory'

class Asesora < Sinatra::Base

  configure do
    enable :cross_origin
  end

  before do
     response.headers['Access-Control-Allow-Origin'] = '*'
  end

  post '/api/translations' do
    params = JSON.parse(request.body.read)
    locale = params['locale']

    translations = Actions.retrieve_dictionary_for(locale).do()

    {data: translations}.to_json
  end

  post '/api/about' do
    application_information = Actions.retrieve_about().do()

    application_information.to_json
  end

  options "*" do
    response.headers["Allow"] = "GET, POST, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end

end
