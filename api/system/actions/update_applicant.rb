require_relative '../services/applicant/service'

module Actions
  class UpdateApplicant
    def self.do(name:, surname:, email:, phonenumber:, ccaa:, id:)
      ::Applicant::Service.update(name, surname, email, phonenumber, ccaa, id)
    end
  end
end
