require_relative '../services/solicitudes/service'

module Actions
  class CountCompanyInSolicitudes
    def self.do(cif:)
      quantity = ::Solicitudes::Service.times_company(cif)

      {data: quantity}
    end
  end
end
