require_relative '../system/domain/solicitude'
require_relative '../asesora'
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

  post '/fixtures/pristine' do
    clean_collections
    fixtures = insert_solicitudes

    { 'fixtures' => fixtures }.to_json
  end

  post '/fixtures/clean' do
    clean_collections

    { 'fixtures': '' }.to_json
  end

  private

  def insert_solicitudes
    solicitude = create_solicitude()
    client['solicitudes'].insert_one(solicitude)

    [solicitude]
  end

  def create_solicitude
    solicitude = Domain::Solicitude.with(NAME, SURNAME, EMAIL, PHONENUMBER, DATE, TEXT, CREATION_MOMENT)
    solicitude.serialize
  end

  def clean_collections
    client['solicitudes'].drop()
  end

  def client
    mongo_uri = ENV['MONGODB_URI']
    Mongo::Logger.logger.level = Logger::INFO

    @client ||= Mongo::Client.new(mongo_uri, { max_pool_size: 5 })
  end
end
