require_relative 'collection'

module Navbar
  class Service
    def self.retrieve
      information = Collection.retrieve
      information.serialize
    end
  end
end
