require_relative '../../domain/solicitude'
require_relative 'collection'

module Solicitudes
  class Service
    def self.create(text, name, surname, email, phonenumber, date)
      solicitude = Domain::Solicitude.with(name, surname, email, phonenumber, date, text)

      Collection.create(solicitude)
    end

    def self.retrieve(id)
      solicitude = Collection.retrieve(id)

      solicitude.serialize
    end

    def self.update(text, name, surname, email, phonenumber, date, creation_moment)
      solicitude = Domain::Solicitude.with(name, surname, email, phonenumber, date, text, creation_moment)

      Collection.update(creation_moment, solicitude)
    end

    def self.all
      Collection.all
    end
  end
end
