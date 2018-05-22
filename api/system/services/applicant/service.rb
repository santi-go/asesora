require_relative '../../domain/applicant'
require_relative 'collection'

module Applicant
  class Service
    def self.create(name, surname, email, phonenumber)
      id = create_id(email, phonenumber)

      applicant = Domain::Applicant.with(name, surname, email, phonenumber, id)
      
      Collection.create(applicant)
    end

    def self.retrieve(id)
      result = Collection.retrieve(id)
      return result.serialize if(result != false)
      return {}
    end

    def self.all(criteria)
      applicants = Collection.all(criteria)
      applicants.map do |applicant|
        applicant.serialize
      end
    end

    def self.create_id(email, phonenumber)
      id = email + phonenumber
    end
  end
end