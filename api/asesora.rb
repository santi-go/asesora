require 'sinatra/base'
require 'sinatra/cross_origin'
require 'json'

require_relative 'endpoints/information'
require_relative 'endpoints/translations'
require_relative 'endpoints/solicitudes'
require_relative 'endpoints/applicants'
require_relative 'endpoints/companies'


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


  Endpoints::Translations.define_retrieve_translations(self)

  Endpoints::Information.define_retrieve_navbar(self)

  Endpoints::Solicitudes.define_create_solicitude(self)
  Endpoints::Solicitudes.define_retrieve_solicitude(self)
  Endpoints::Solicitudes.define_retrieve_solicitudes(self)
  Endpoints::Solicitudes.define_update_solicitude(self)
  Endpoints::Solicitudes.define_delete_solicitude(self)
  Endpoints::Solicitudes.define_retrieve_cnae(self)
  Endpoints::Solicitudes.define_retrieve_ccaa(self)
  Endpoints::Solicitudes.define_create_subject(self)
  Endpoints::Solicitudes.define_update_subject(self)
  Endpoints::Solicitudes.define_close_subject(self)
  Endpoints::Solicitudes.define_retrieve_subjects(self)
  Endpoints::Solicitudes.define_retrieve_topics(self)
  Endpoints::Solicitudes.define_retrieve_proposals(self)


  Endpoints::Applicants.define_update_applicant(self)
  Endpoints::Applicants.define_search_applicants(self)

  Endpoints::Companies.define_update_company(self)
  Endpoints::Companies.define_company_matches(self)
  Endpoints::Companies.define_duplicated_company(self)
  Endpoints::Companies.define_count_company_in_solicitudes(self)


  options "*" do
    response.headers["Allow"] = "GET, POST, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end
end
