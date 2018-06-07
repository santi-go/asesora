require_relative '../services/solicitudes/service'

module Actions
  class DeleteSolicitude
    def self.do(id:)
      ::Solicitudes::Service.delete(id)
    end
  end
end
