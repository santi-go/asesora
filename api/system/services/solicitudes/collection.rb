require_relative '../../domain/solicitude'
require 'mongo'

module Solicitudes
  class Collection
    class << self
      def create(solicitude)
        serialized = solicitude.serialize()

        document = MongoClient.create(serialized)

        Domain::Solicitude.from_document(document)
      end

      private

      class MongoClient
        class << self
          def create(descriptor)
            client[:solicitudes].insert_one(descriptor)
            descriptor
          end

          private

          def client
            mongo_uri = ENV['MONGODB_URI']
            Mongo::Logger.logger.level = Logger::INFO

            @client ||= Mongo::Client.new(mongo_uri)
          end
        end
      end
    end
  end
end
