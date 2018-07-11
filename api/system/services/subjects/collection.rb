require_relative '../../domain/subject'

require 'mongo'

module Subjects
  class Collection
    class << self
      def create(subject)
        serialized = subject.serialize()

        document = MongoClient.create(serialized)
        Domain::Subject.from_document(document)
      end

      def update(subject, id)
        serialized = subject.serialize()

        document = MongoClient.update(serialized, id)

        return if document.nil?

        Domain::Subject.from_document(document)
      end

      def retrieve(id)
        subject = MongoClient.find(id)

        Domain::Subject.from_document(subject)
      end

      def all_by(solicitude_id)
        subjects = MongoClient.all_by(solicitude_id)

        Domain::List.from_document(subjects, Domain::Subject)
      end

      private

    class MongoClient
      class << self
        def create(descriptor)
          client[:subjects].insert_one(descriptor)
          descriptor
        end

        def all_by(solicitude_id)
          client[:subjects].find({"solicitude_id": solicitude_id})
        end

        def update(subject, id)
          client[:subjects].find_one_and_replace({ "id": id }, subject, :return_document => :after)
        end

        def find(id)
          client[:subjects].find({"id": id}).first
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
