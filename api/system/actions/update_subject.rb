require_relative '../services/subjects/service'

module Actions
  class UpdateSubject
    def self.do(solicitude_id:, id:, proposal:, description:, analysis:, topics:)
      ::Subjects::Service.update(solicitude_id, id, proposal, description, analysis, topics)
    end
  end
end
