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

      def update(creation_moment, solicitude)
        serialized = solicitude.serialize()

        document = MongoClient.update(creation_moment, serialized)

        return if document.nil?

        Domain::Solicitude.from_document(document)
      end

      def retrieve(id)
        document = MongoClient.retrieve(id)

        solicitude = Domain::Solicitude.from_document(document)

        solicitude
      end

      def all
        solicitudes = MongoClient.all

        Domain::ListSolicitudes.from_document(solicitudes)
      end

      private

      class MongoClient
        DESCENDENT = -1
        class << self

          def create(descriptor)
            client[:solicitudes].insert_one(descriptor)
            descriptor
          end

          def retrieve(id)
            documents = client[:solicitudes].find({"creation_moment": id})
            documents.first
          end

          def update(creation_moment, data)
            client[:solicitudes].find_one_and_replace({ creation_moment: creation_moment }, data, :return_document => :after)
          end

          def all
            client[:solicitudes].find().sort({"date": DESCENDENT, "creation_moment": DESCENDENT})
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
