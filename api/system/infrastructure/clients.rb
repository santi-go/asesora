require 'mongo'

module Infrastructure
  class Clients
    def self.mongo
      mongo_uri = ENV['MONGODB_URI']
      Mongo::Logger.logger.level = Logger::INFO

      Mongo::Client.new(mongo_uri, { max_pool_size: 5 })
    end
  end
end 
