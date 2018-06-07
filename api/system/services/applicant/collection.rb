require_relative '../../domain/applicant'

require 'mongo'

module Applicant
  class Collection
    class << self
      def create(applicant)
        memento = applicant.memento
        serialized = applicant.serialize()

        document = MongoClient.create(serialized)
        MongoClient.store(memento)
        Domain::Applicant.from_document(document)
      end

      def retrieve(id, timestamp=Time.now.to_i)
        document = MongoClient.retrieve(id)
        applicant = Domain::Applicant.from_document(document)
        memento = MongoClient.retrieve_state_at(timestamp,applicant.identify)
        applicant.remind(memento)
        applicant
      end

      def all_by(criteria)
        minimun_length = 3
        list = criteria.select{ |field, value| value.length >= minimun_length }

        result = MongoClient.all_by(list)

        applicants = result.map do |applicant|
          Domain::Applicant.from_document(applicant)
        end
        applicants
      end

      def update(applicant, id)
        serialized = applicant.serialize()
        memento = applicant.memento
        document = MongoClient.update(serialized, id)

        return if document.nil?
        MongoClient.store memento
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

        def store (memento)
          client[:applicant_memento].insert_one(memento)
        end

        def retrieve(id)
          documents = client[:applicant].find({"id": id})
          documents.first
        end

        def retrieve_state_at(timestamp, id)
          memento = client[:applicant_memento]
                          .find({"timestamp":{"$lte": timestamp},"signature": id})
                          .sort({"timestamp": -1})
                          .first
          memento
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
