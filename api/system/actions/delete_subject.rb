require_relative '../services/subjects/service'

module Actions
  class DeleteSubject
    def self.do(id:)
      subject = ::Subjects::Service.retrieve(id)
      return "500" if subject == {}

      ::Subjects::Service.delete(id)
    end
  end
end
