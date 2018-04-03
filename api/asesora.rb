require 'sinatra/base'
require 'sinatra/cross_origin'
require 'json'

class Asesora < Sinatra::Base

  configure do
    enable :cross_origin
  end

  before do
     response.headers['Access-Control-Allow-Origin'] = '*'
  end

  options "*" do
    response.headers["Allow"] = "GET, POST, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end

end
