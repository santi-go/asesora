require_relative '../../domain/applicant'
require_relative '../../domain/list'

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
        document = MongoClient.retrieve(id) || {}
        applicant = Domain::Applicant.from_document(document)
        applicant
      end

      def delete(id)
        MongoClient.delete(id)
      end

      def all_by(criteria)
        minimun_length = 3
        list = criteria.select{ |field, value| value.length >= minimun_length }

        applicants = MongoClient.all_by(list)

        Domain::List.from_document(applicants, Domain::Applicant)
      end

      def update(applicant, id)
        serialized = applicant.serialize()

        document = MongoClient.update(serialized, id)

        return if document.nil?

        Domain::Applicant.from_document(document)
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

        def delete(id)
          client[:applicant].find_one_and_delete({"id": id})
        end

        def all_by(criteria)
          list = {}
          criteria.each do |key, value|
            regex = /#{value}/i
            chain = { key => {"$regex": regex}}
            list.merge!(chain)
          end
          documents = client[:applicant].find(list)
        end

        def update(applicant, id)
          client[:applicant].find_one_and_replace({ "id": id }, applicant, :return_document => :after)
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
