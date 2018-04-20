require_relative '../services/solicitudes/service'

module Actions
  class UpdateSolicitude
    def self.do(text:, applicant:, date:, creation_moment:)
      ::Solicitudes::Service.update(text, applicant, date, creation_moment)
    end
  end
end
