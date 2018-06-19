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

      private

    class MongoClient
      class << self
        def create(descriptor)
          client[:subjects].insert_one(descriptor)
          descriptor
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
