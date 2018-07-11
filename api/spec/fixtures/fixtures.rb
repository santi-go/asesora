# encoding: UTF-8
require_relative '../../system/services/companies/service'
require_relative '../../system/services/applicant/service'
require_relative '../../system/services/solicitudes/service'
require_relative '../../system/actions/retrieve_solicitude'

require 'mongo'

class Fixtures
  CREATION_MOMENT = '1234567890'
  SOLICITUDES_COUNT = 3
  SOLICITUDES_COUNT_FOR_DEFAULT_COMPANY = 2
  DATE = '2018-04-25'
  TEXT = 'La primera solicitud'
  DATE_1 = '2018-04-25'
  TEXT_1 = 'La primera solicitud'
  APPLICANT_NAME = 'Piedad'
  APPLICANT_SURNAME = 'Alarcón'
  APPLICANT_EMAIL = 'piedadalarcon@noname.es'
  APPLICANT_CCAA = '01 - Baleares'
  APPLICANT_CCAA_2 = '02 - Cataluña'
  APPLICANT_PHONENUMBER = '000111000'
  COMPANY_NAME = 'De Rape SL'
  COMPANY_CIF = 'A98005978'
  COMPANY_EMPLOYEES = '34'
  COMPANY_CNAE = '931 - Actividades deportivas'
  TEXT_2 = 'La primera solicitud'
  APPLICANT_NAME_2 = 'Piedad'
  APPLICANT_SURNAME_2 = 'Romero'
  APPLICANT_EMAIL_2 = 'hidalgoromero@noname.es'
  APPLICANT_PHONENUMBER_2 = '000222000'
  COMPANY_NAME_2 = 'Campigue SAL'
  COMPANY_CIF_2 = 'H15103393'
  COMPANY_EMPLOYEES_2 = '34'
  COMPANY_CNAE_2 = '870 - Asistencia en establecimientos residenciales'
  COMPANY_CIF_3 = 'U7053991A'
  PROPOSAL = 'Propuestas de actuación'
  PROPOSAL_2 = 'Otras Propuestas de actuación'
  DESCRIPTION = 'Descripción de la propuesta'
  DESCRIPTION_2 = 'Descripción de la propuesta 2'
  ANALYSIS = 'Análisis de la solicitud'
  ANALYSIS_2 = 'Otros Análisis de la solicitud'
  TOPICS = 'Temas del caso'

  def pristine
    clean_collections
    insert_solicitudes
  end

  def clean_collections
    client['solicitudes'].drop()
    client['companies'].drop()
    client['applicant'].drop()
    client['company_memento'].drop()
    client['subjects'].drop()
  end

  private

  def insert_solicitudes()
    first_company = create_company(COMPANY_NAME, COMPANY_CIF, COMPANY_EMPLOYEES, COMPANY_CNAE)
    first_applicant = create_applicant(APPLICANT_NAME, APPLICANT_SURNAME, APPLICANT_EMAIL, APPLICANT_PHONENUMBER, APPLICANT_CCAA)
    first_solicitude = create_solicitude(first_applicant, first_company)
    second_company = create_company(COMPANY_NAME_2, COMPANY_CIF_2, COMPANY_EMPLOYEES_2, COMPANY_CNAE_2)
    second_applicant = create_applicant(APPLICANT_NAME_2, APPLICANT_SURNAME_2, APPLICANT_EMAIL_2, APPLICANT_PHONENUMBER_2, APPLICANT_CCAA_2)
    second_solicitude = create_solicitude(second_applicant, second_company)
    third_solicitude = create_solicitude(second_applicant, first_company)

    [first_solicitude, second_solicitude, third_solicitude]
  end

  def create_company(name, cif, employees, cnae)
    ::Companies::Service.create(name, cif, employees, cnae)
  end

  def create_applicant(name, surname, email, phonenumber, ccaa)
    ::Applicant::Service.create(name, surname, email, phonenumber, ccaa)
  end

  def create_solicitude(applicant, company)
    solicitude = ::Solicitudes::Service.create(DATE_1, TEXT_1, applicant["id"], company["cif"])
    full_solicitude = ::Actions::RetrieveSolicitude.do(id: solicitude["creation_moment"])

    full_solicitude
  end

  def client
    mongo_uri = ENV['MONGODB_URI']
    Mongo::Logger.logger.level = Logger::INFO

    @client ||= Mongo::Client.new(mongo_uri, { max_pool_size: 5 })
  end
end
