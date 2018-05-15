require 'sinatra/base'
require 'sinatra/cross_origin'
require 'json'

require_relative 'system/actions/create_solicitude'
require_relative 'system/actions/retrieve_solicitudes'
require_relative 'system/actions/retrieve_about'
require_relative 'system/actions/retrieve_dictionary'
require_relative 'system/actions/retrieve_cnae'
require_relative 'system/actions/retrieve_solicitude'
require_relative 'system/domain/solicitude'
require_relative 'system/actions/retrieve_company'


class Asesora < Sinatra::Base
  API_HOST=ENV['API_HOST']

  configure do
    enable :cross_origin if API_HOST == 'localhost'
    set :bind, API_HOST
    set :raise_errors, true
    set :show_exceptions, false
  end

  before do
     response.headers['Access-Control-Allow-Origin'] = '*'
     content_type 'application/json'
  end

  get '/' do
    redirect '/index.html'
  end

  post '/api/translations' do
    params = JSON.parse(request.body.read)

    translations = Actions::RetrieveDictionary.do(locale: params['locale'])

    {data: translations}.to_json
  end

  post '/api/about' do
    application_information = Actions::RetrieveAbout.do()

    application_information.to_json
  end

  post '/api/create-solicitude' do
    params = JSON.parse(request.body.read)
    data = {
      text:params['text'],
      name:params['name'],
      surname:params['surname'],
      email:params['email'],
      phonenumber:params['phonenumber'],
      date:params['date'],
      company_name:params['companyName'],
      company_cif:params['companyCif'],
      company_employees:params['companyEmployees'],
      company_cnae:params['companyCnae']
    }

    created = Actions::CreateSolicitude.do(data)
    created.to_json
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
    company_name = params['companyName']
    company_cif = params['companyCif']
    company_employees = params['companyEmployees']
    company_cnae = params['companyCnae']

    updated = Actions.update_solicitude(text, name, surname, email, phonenumber, date, company_name, company_cif, company_employees, company_cnae, creation_moment).do()

    return {}.to_json if updated.nil?

    updated.serialize.to_json
  end

  post '/api/retrieve-solicitudes' do
    retrieve_solicitudes = Actions::RetrieveSolicitudes.do()

    list_solicitudes = retrieve_solicitudes

    {data: list_solicitudes}.to_json

  end

  post '/api/retrieve-solicitude' do
    params = JSON.parse(request.body.read)

    solicitude = Actions::RetrieveSolicitude.do(id: params['id'])

    {data: solicitude}.to_json

  end

  post '/api/cnae' do
    cnae_catalog = Actions::RetrieveCnae.do()
    {data: cnae_catalog}.to_json
  end

  post '/api/duplicated-company' do
    params = JSON.parse(request.body.read)
    company = Actions::RetrieveCompany.do(id: params['id'])
    company.to_json
  end

  post '/api/company-matches' do
    params = JSON.parse(request.body.read)

    criteria = {
      name: params['name'],
      cnae: params['cnae']
    }
    companies = Actions::RetrieveSolicitudes.do_companies(criteria)

    {data: companies}.to_json
  end

  options "*" do
    response.headers["Allow"] = "GET, POST, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end

end
