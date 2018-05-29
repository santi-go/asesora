require_relative '../../system/services/companies/service'
require_relative '../../system/services/solicitudes/service'
require_relative '../../system/services/translation/collection'
require_relative '../../asesora'
require 'mongo'
require 'net/http'
require 'json'
require 'date'

class Fixtures < Asesora
  DATE_1 = '2018-04-25'
  TEXT_1 = 'La primera solicitud'
  APPLICANT_NAME_1 = 'Piedad'
  APPLICANT_SURNAME_1 = 'Alarcón'
  APPLICANT_EMAIL_1 = 'piedadalarcon@noname.es'
  APPLICANT_PHONENUMBER_1 = '000111000'
  COMPANY_NAME_1 = 'De Rape SL'
  COMPANY_CIF_1 = 'A98005978'
  COMPANY_EMPLOYEES_1 = '34'
  COMPANY_CNAE_1 = '931 - Actividades deportivas'

  DATE_2 = '2018-04-28'
  TEXT_2 = 'Solicitud de asesoramiento'
  APPLICANT_NAME_2 = 'Hidalgo'
  APPLICANT_SURNAME_2 = 'Romero'
  APPLICANT_EMAIL_2 = 'hidalgoromero@noname.es'
  APPLICANT_PHONENUMBER_2 = '000222000'
  COMPANY_NAME_2 = 'Campigue SAL'
  COMPANY_CIF_2 = 'F7575797A'
  COMPANY_EMPLOYEES_2 = '34'
  COMPANY_CNAE_2 = '870 - Asistencia en establecimientos residenciales'

  DATE_3 = '2018-04-20'
  TEXT_3 = 'Pendiente recogida de datos'
  APPLICANT_NAME_3 = 'Alberto J.'
  APPLICANT_SURNAME_3 = 'Connor'
  APPLICANT_EMAIL_3 = ''
  APPLICANT_PHONENUMBER_3 = '000333000'
  COMPANY_NAME_3 = 'Campigue Coop V'
  COMPANY_CIF_3 = 'U7053991A'
  COMPANY_EMPLOYEES_3 = '34'
  COMPANY_CNAE_3 = '870 - Asistencia en establecimientos residenciales'

  def self.locale
    Translation::Collection::DEFAULT_LOCALE
  end

  post '/fixtures/staging_pristine' do
    clean_collections
    fixtures = insert_solicitude(DATE_1, TEXT_1, APPLICANT_NAME_1, APPLICANT_SURNAME_1, APPLICANT_EMAIL_1, APPLICANT_PHONENUMBER_1, COMPANY_NAME_1, COMPANY_CIF_1, COMPANY_EMPLOYEES_1, COMPANY_CNAE_1)
    fixtures = insert_solicitude(DATE_2, TEXT_2, APPLICANT_NAME_2, APPLICANT_SURNAME_2, APPLICANT_EMAIL_2, APPLICANT_PHONENUMBER_2, COMPANY_NAME_2, COMPANY_CIF_2, COMPANY_EMPLOYEES_2, COMPANY_CNAE_2)
    fixtures = insert_solicitude(DATE_3, TEXT_3, APPLICANT_NAME_3, APPLICANT_SURNAME_3, APPLICANT_EMAIL_3, APPLICANT_PHONENUMBER_3, COMPANY_NAME_3, COMPANY_CIF_3, COMPANY_EMPLOYEES_3, COMPANY_CNAE_3)

    { 'fixtures' => fixtures }.to_json
  end

  private

  def insert_solicitude(date, text, name, surname, email, phonenumber, company_name, company_cif, company_employees, company_cnae)
    company = create_company(company_name, company_cif, company_employees, company_cnae)
    applicant = create_applicant(name, surname, email, phonenumber)
    solicitude = create_solicitude(date, text, applicant, company)

    [solicitude]
  end

  def create_solicitude(date, text, applicant, company)
    ::Solicitudes::Service.create(date, text, applicant.identify(), company.identify())
  end

  def create_applicant(name, surname, email, phonenumber)
    ::Applicant::Service.create(name, surname, email, phonenumber)
  end

  def create_company(name, cif, employees, cnae)
    ::Companies::Service.create(name, cif, employees, cnae)
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
