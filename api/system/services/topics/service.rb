require 'json'

module Topics
  class Service
    def self.all
      from_path = File.dirname(__FILE__)
      collection_file = File.join(from_path, "collection.json")
      catalog = File.read(collection_file, encoding: 'UTF-8')
      JSON.parse(catalog)
    end
  end
end
