require_relative '../services/solicitudes/service'

module Actions
  class UpdateSolicitude
    def self.do(text:, name:, surname:, email:, phonenumber:, date:, creation_moment:)
      ::Solicitudes::Service.update(text, name, surname, email, phonenumber, date, creation_moment)
    end
  end
end
