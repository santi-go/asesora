require_relative '../../domain/applicant'
require 'mongo'

module Applicant
  class Collection
    class << self
      def create(applicant)
        serialized = applicant.serialize()

        document = MongoClient.create(serialized)
        Domain::Applicant.from_document(document)
      end

      def retrieve(id)
        document = MongoClient.retrieve(id)

        applicant = Domain::Applicant.from_document(document)
        applicant
      end
    end

      private

    class MongoClient
      class << self
        def create(descriptor)
          client[:applicant].insert_one(descriptor)
          descriptor
        end

        def retrieve(id)
          documents = client[:applicant].find({"id": id})
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
