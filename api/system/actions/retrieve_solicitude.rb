require_relative '../services/solicitudes/service'

module Actions
  class RetrieveSolicitude
    def self.do(id:)
      ::Solicitudes::Service.retrieve(id)
    end
  end
end
