require_relative '../../domain/solicitude'
require_relative 'collection'

module Solicitudes
  class Service
    def self.create(text, applicant, date)
      solicitude = Domain::Solicitude.new(applicant, date)
      solicitude.text = text

      Collection.create(solicitude)
    end

    def self.retrieve(id)
      solicitude = Collection.retrieve(id)

      solicitude.serialize
    end

    def self.update(text, applicant, date, creation_moment)
      solicitude = Domain::Solicitude.new(applicant, date, creation_moment)
      solicitude.text = text

      Collection.update(creation_moment, solicitude)
    end

    def self.all
      Collection.all
    end
  end
end
