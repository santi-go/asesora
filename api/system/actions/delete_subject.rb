require_relative '../services/subjects/service'

module Actions
  class DeleteSubject
    def self.do(solicitude_id:, id:)
      subject = ::Subjects::Service.retrieve(solicitude_id, id)
      return "500" if subject == {}

      ::Subjects::Service.delete(id)
    end
  end
end
