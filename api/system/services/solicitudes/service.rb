require_relative '../../domain/solicitude'
require_relative 'collection'

module Solicitudes
  class Service
    def self.create(date, text, source, applicant, company)
      solicitude = Domain::Solicitude.with(date, text, source, applicant, company)

      Collection.create(solicitude).serialize
    end

    def self.retrieve(id)
      solicitude = Collection.retrieve(id)
      return {} if solicitude == nil
      solicitude.serialize
    end

    def self.delete(id)
      Collection.delete(id)
    end

    def self.update(date, text, source, applicant, company, creation_moment)
      return nil if applicant.nil?
      solicitude = Domain::Solicitude.with(date, text, source, applicant, company, creation_moment)
      Collection.update(creation_moment, solicitude).serialize
    end

    def self.times_company(cif)
      return 0 if cif.nil?
      cif = cif.upcase

      Collection.times_company(cif)
    end

    def self.all
      Collection.all.serialize
    end

    def self.all_by(criteria)
      solicitudes = Collection.all_by(criteria)
      solicitudes.map do |solicitude|
        solicitude.serialize
      end
    end

  end
end
