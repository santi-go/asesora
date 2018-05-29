require_relative '../../system/services/companies/service'
require_relative '../../system/services/solicitudes/service'
require_relative '../../system/services/translation/collection'
require_relative '../../asesora'
require 'mongo'
require 'json'


class Fixtures < Asesora
  APPLICANT_NAME = 'John'
  APPLICANT_SURNAME = 'Doe'
  APPLICANT_EMAIL = 'john@doe.com'
  APPLICANT_PHONENUMBER = '987654321'
  APPLICANT_NAME_2 = 'John'
  APPLICANT_SURNAME_2 = 'Connor'
  APPLICANT_EMAIL_2 = 'john@doe.com'
  APPLICANT_PHONENUMBER_2 = '600100200'
  DATE = '2018-04-25'
  CREATION_MOMENT = '1234567890'
  TEXT = 'Solicitude text'
  TEXT_2 = '2 Solicitude text'
  SOLICITUDES_COUNT = 1
  COMPANY_NAME = 'Company'
  COMPANY_NAME_2 = 'Company2'
  COMPANY_CIF = 'A98005978'
  COMPANY_CIF_2 = 'F7575797A'
  COMPANY_CIF_3 = 'U7053991A'
  COMPANY_EMPLOYEES = '34'
  COMPANY_CNAE = '931 - Actividades deportivas'
  COMPANY_CNAE_2 = '870 - Asistencia en establecimientos residenciales'

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
    applicant = create_applicant
    solicitude = create_solicitude(applicant, company)

    [solicitude]
  end

  def create_applicant
    ::Applicant::Service.create(APPLICANT_NAME, APPLICANT_SURNAME, APPLICANT_EMAIL, APPLICANT_PHONENUMBER)
  end

  def create_solicitude(applicant, company)
    ::Solicitudes::Service.create(DATE, TEXT, applicant.identify(), company.identify())
  end

  def create_company
    ::Companies::Service.create(COMPANY_NAME, COMPANY_CIF, COMPANY_EMPLOYEES, COMPANY_CNAE)
  end

  def clean_collections
    client['solicitudes'].drop()
    client['companies'].drop()
    client['applicant'].drop()
  end

  def client
    mongo_uri = ENV['MONGODB_URI']
    Mongo::Logger.logger.level = Logger::INFO

    @client ||= Mongo::Client.new(mongo_uri, { max_pool_size: 5 })
  end
end
