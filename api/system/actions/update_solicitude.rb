require_relative '../services/solicitudes/service'

module Actions
  class UpdateSolicitude
    def self.do(date:, text:, source:, id:, company_cif:, creation_moment:)
      company_id = company_cif
      applicant_id = id
      ::Solicitudes::Service.update(date, text, source, applicant_id, company_id, creation_moment)
    end
  end
end
