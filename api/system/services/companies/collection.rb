require_relative '../../domain/company'
require 'mongo'

module Companies
  class Collection
    class << self
      def create(company)
        serialized = company.serialize()

        document = MongoClient.create(serialized)

        Domain::Company.from_document(document)
      end

      def retrieve(id)
        document = MongoClient.retrieve(id)
        return false if document.nil?
        company= Domain::Company.from_document(document)
        company
      end
      private

      class MongoClient
        class << self

          def create(descriptor)
            client[:companies].insert_one(descriptor)
            descriptor
          end

          def retrieve(id)
            documents = client[:companies].find({"cif": id})
            documents.first
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
