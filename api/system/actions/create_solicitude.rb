require_relative '../services/solicitudes/service'

module Actions
  class CreateSolicitude
    def self.do(text:, name:, surname:, email:, phonenumber:, date:)
      ::Solicitudes::Service.create(text, name, surname, email, phonenumber, date)
    end
  end
end
