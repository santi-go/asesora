require_relative '../services/subjects/service'

module Actions
  class UpdateSubject
    def self.do(id:, proposal:, analysis:, topics:)
      ::Subjects::Service.update(id, proposal, analysis, topics)
    end
  end
end
