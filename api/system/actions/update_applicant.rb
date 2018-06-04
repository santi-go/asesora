require_relative '../services/applicant/service'

module Actions
  class UpdateApplicant
    def self.do(name:, surname:, email:, phonenumber:, id:)
      ::Applicant::Service.update(name, surname, email, phonenumber, id)
    end
  end
end