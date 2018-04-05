require_relative 'collection'

module Translation
  class Service
    def self.retrieve(locale)
        Collection.retrieve(locale)
    end
  end
end
