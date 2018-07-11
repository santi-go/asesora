require_relative '../../domain/navbar'
require 'mongo'

module Navbar
  class Collection
    DEFAULT_ABOUT = {
      "name" => 'Asesora',
      "description" => 'description',
      "version" => '0.0.1'
    }

    class << self
      def retrieve
        document = find

        Domain::Navbar.from_document(document)
      end

      private

      def find
        get_navbar
      end

      def get_navbar
        MongoClient.navbar()
      end

      class MongoClient
        class << self

          def navbar
            return set_default if client[:navbar].count({})== 0
            client[:navbar].find().first
          end

          def set_default
              client[:navbar].insert_one(DEFAULT_ABOUT)
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
