require_relative '../../system/services/companies/service'
require_relative '../../system/services/solicitudes/service'
require_relative '../../system/services/translation/collection'
require_relative '../../asesora'
require 'mongo'
require 'json'


class Fixtures < Asesora
  NAME = 'John'
  SURNAME = 'Doe'
  EMAIL = 'john@doe.com'
  PHONENUMBER = '987654321'
  DATE = '2018-04-25'
  CREATION_MOMENT = '1234567890'
  TEXT = 'Solicitude text'
  SOLICITUDES_COUNT = 1
  COMPANY_NAME = 'Company'
  COMPANY_NAME_2 = 'Company2'
  COMPANY_CIF = "A98005978"
  COMPANY_EMPLOYEES = "34"
  COMPANY_CNAE = "931 - Actividades deportivas"
  COMPANY_CNAE_2 = "870 - Asistencia en establecimientos residenciales"
  COMPANY_CIF_3 = "26751998P"
  COMPANY_CIF_4 = "22674411E"
  

  def self.locale
    Translation::Collection::DEFAULT_LOCALE
  end  
  
  post '/fixtures/pristine' do
    clean_collections
    fixtures = insert_solicitudes
    
    { 'fixtures' => fixtures }.to_json
  end
  
  post '/fixtures/clean' do
    clean_collections
    
    { 'fixtures': [] }.to_json
  end
  
  private
  
  def insert_solicitudes()
    company = create_company
    solicitude = create_solicitude(company)

    [solicitude]
  end

  def create_solicitude(company)
    ::Solicitudes::Service.create(TEXT, NAME, SURNAME, EMAIL, PHONENUMBER, DATE, company.identify())
  end

  def create_company
    ::Companies::Service.create(COMPANY_NAME, COMPANY_CIF, COMPANY_EMPLOYEES, COMPANY_CNAE)
  end

  def clean_collections
    client['solicitudes'].drop()
    client['companies'].drop()
  end

  def client
    mongo_uri = ENV['MONGODB_URI']
    Mongo::Logger.logger.level = Logger::INFO

    @client ||= Mongo::Client.new(mongo_uri, { max_pool_size: 5 })
  end
end
