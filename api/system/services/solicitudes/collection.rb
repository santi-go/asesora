require_relative '../../domain/solicitude'
require_relative '../../domain/list_solicitudes'

require 'mongo'

module Solicitudes
  class Collection
    class << self
      def create(solicitude)
        serialized = solicitude.serialize()

        document = MongoClient.create(serialized)

        Domain::Solicitude.from_document(document)
      end

      def retrieve
        solicitudes = MongoClient.retrieve

        Domain::ListSolicitudes.from_document(solicitudes)
      end

      private

      class MongoClient
        class << self
          def create(descriptor)
            client[:solicitudes].insert_one(descriptor)
            descriptor
          end

          def retrieve
            client[:solicitudes].find()
          end

          private

          def client
            mongo_uri = ENV['MONGODB_URI']
            Mongo::Logger.logger.level = Logger::INFO

            @client ||= Mongo::Client.new(mongo_uri, { max_pool_size: 5 })
          end
        end
      end
    end
  end
end
