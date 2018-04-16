require_relative '../../domain/solicitude'
require_relative 'collection'

module Solicitudes
  class Service
    def self.create(text, applicant, date)
      solicitude = Domain::Solicitude.new(applicant, date)
      solicitude.text = text

      Collection.create(solicitude)
    end
  end
end
