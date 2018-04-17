require_relative '../../domain/about'
require 'mongo'

module About
  class Collection
    DEFAULT_ABOUT = {
      "name" => 'Asesora',
      "description" => 'description',
      "version" => '0.0.1'
    }

    class << self
      def retrieve
        document = find

        Domain::About.from_document(document)
      end

      private

      def find
        get_about
      end

      def get_about
        MongoClient.about()
      end

      class MongoClient
        class << self

          def about
            return set_default if client[:about].count({})== 0
            client[:about].find().first
          end

          def set_default
              client[:about].insert_one(DEFAULT_ABOUT)
              DEFAULT_ABOUT
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
