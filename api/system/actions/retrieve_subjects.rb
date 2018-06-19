require_relative '../services/subjects/service'

module Actions
  class RetrieveSubjects
    def self.do(solicitude_id:)
      ::Subjects::Service.all_by(solicitude_id)
    end
  end
end
