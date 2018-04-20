require_relative '../services/solicitudes/service'

module Actions
  class RetrieveSolicitudes
    def self.do(*_)
        ::Solicitudes::Service.all
    end
  end
end
