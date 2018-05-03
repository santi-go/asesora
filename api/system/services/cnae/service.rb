require 'json'

module Cnae
  class Service
    def self.all
      catalog = File.read("system/services/cnae/collection.json", encoding: 'UTF-8')

      JSON.parse(catalog)
    end
  end
end
