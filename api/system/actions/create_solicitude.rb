require_relative '../services/solicitudes/service'

module Actions
  class CreateSolicitude
    def self.do(text:, applicant:, date:)
      ::Solicitudes::Service.create(text, applicant, date)
    end
  end
end
