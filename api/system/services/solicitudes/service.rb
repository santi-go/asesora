require_relative '../../domain/solicitude'
require_relative 'collection'

module Solicitudes
  class Service
    def self.create(text, name, surname, email, phonenumber, date, company)
      solicitude = Domain::Solicitude.with(name, surname, email, phonenumber, date, text, company)

      Collection.create(solicitude).serialize
    end

    def self.retrieve(id)
      solicitude = Collection.retrieve(id)

      solicitude.serialize
    end

    def self.update(text, name, surname, email, phonenumber, date, company, creation_moment)
      solicitude = Domain::Solicitude.with(name, surname, email, phonenumber, date, text, company, creation_moment)

      Collection.update(creation_moment, solicitude).serialize
    end

    def self.all
      Collection.all.serialize
    end
  end
end
