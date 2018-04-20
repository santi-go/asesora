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

      def all
        solicitudes = MongoClient.all

        Domain::ListSolicitudes.from_document(solicitudes)
      end

      def retrieve(id)
        document = MongoClient.retrieve(id)

        solicitude = Domain::Solicitude.from_document(document)

        solicitude
      end

      private

      class MongoClient
        class << self
          def create(descriptor)
            client[:solicitudes].insert_one(descriptor)
            descriptor
          end

          def all
            client[:solicitudes].find().sort({"date": -1, "creation_moment": -1})
          end

          def retrieve(id)
            document = client[:solicitudes].find({ "creation_moment": id })
            document.first
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
