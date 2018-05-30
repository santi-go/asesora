require_relative '../services/solicitudes/service'

module Actions
  class CountCompanyInSolicitudes
    def self.do(cif:)
      ::Solicitudes::Service.times_company(cif)
    end
  end
end
