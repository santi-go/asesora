require_relative '../../domain/solicitude'
require_relative 'collection'

module Solicitudes
  class Service
    def self.create(date, text, applicant, company)
      solicitude = Domain::Solicitude.with(date, text, applicant, company)

      Collection.create(solicitude).serialize
    end

    def self.retrieve(id)
      solicitude = Collection.retrieve(id)

      solicitude.serialize
    end

    def self.update(date, text, applicant, company, creation_moment)
      return nil if applicant.nil?
      solicitude = Domain::Solicitude.with(date, text, applicant, company, creation_moment)
      Collection.update(creation_moment, solicitude).serialize
    end

    def self.times_company(cif)
      cif = cif.upcase
      result = Collection.times_company(cif)
      {"data": result}
    end

    def self.all
      Collection.all.serialize
    end
  end
end
