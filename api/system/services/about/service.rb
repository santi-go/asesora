require_relative 'collection'

module About
  class Service
    def self.retrieve
      information = Collection.retrieve
      information.serialize
    end
  end
end
