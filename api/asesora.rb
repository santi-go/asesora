require 'sinatra/base'
require 'sinatra/cross_origin'
require 'json'

require_relative 'system/actions/factory'
require_relative 'system/domain/solicitude'

class Asesora < Sinatra::Base

  configure do
    enable :cross_origin
    set :raise_errors, true
    set :show_exceptions, false
  end

  before do
     response.headers['Access-Control-Allow-Origin'] = '*'
     content_type 'application/json'
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

  post '/api/create-solicitude' do
    params = JSON.parse(request.body.read)
    text = params['text']
    name = params['name']
    surname = params['surname']
    email = params['email']
    phonenumber = params['phonenumber']
    date = params['date']

    created = Actions.create_solicitude(text, name, surname, email, phonenumber, date).do()
    created.serialize.to_json
  end

  post '/api/update-solicitude' do
    params = JSON.parse(request.body.read)
    text = params['text']
    name = params['name']
    surname = params['surname']
    email = params['email']
    phonenumber = params['phonenumber']
    date = params['date']
    creation_moment = params['creation_moment']

    updated = Actions.update_solicitude(text, name, surname, email, phonenumber, date, creation_moment).do()

    return {}.to_json if updated.nil?

    updated.serialize.to_json
  end

  post '/api/retrieve-solicitudes' do
    retrieve_solicitudes = Actions.retrieve_solicitudes().do()

    list_solicitudes = retrieve_solicitudes.serialize

    {data: list_solicitudes}.to_json

  end

  post '/api/retrieve-solicitude' do
    params = JSON.parse(request.body.read)

    id = params['id']

    solicitude = Actions.retrieve_solicitude(id).do()

    {data: solicitude}.to_json

  end

  options "*" do
    response.headers["Allow"] = "GET, POST, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end

end
