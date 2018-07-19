require 'sinatra/base'
require 'sinatra/cross_origin'
require 'json'

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


  Endpoints::Translations.define_endpoints(self)

  Endpoints::Solicitudes.define_endpoints(self)

  Endpoints::Applicants.define_endpoints(self)

  Endpoints::Companies.define_endpoints(self)

  options "*" do
    response.headers["Allow"] = "GET, POST, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end
end
