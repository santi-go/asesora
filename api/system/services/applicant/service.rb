require 'securerandom'

require_relative '../../domain/applicant'
require_relative 'collection'

module Applicant
  class Service
    def self.create(name, surname, email, phonenumber)
      id = create_id

      applicant = Domain::Applicant.with(name, surname, email, phonenumber, id)

      Collection.create(applicant)
    end

    def self.retrieve_with_id(name, surname, email, phonenumber, id)
      Collection.retrieve(id)
    end

    def self.retrieve(id)
      result = Collection.retrieve(id)
      return result.serialize if(result != false)
      return {}
    end

    def self.all_by(criteria)
      applicants = Collection.all_by(criteria)
      applicants.map do |applicant|
        applicant.serialize
      end
    end

    def self.create_id
      id = SecureRandom.uuid
    end
  end
end
