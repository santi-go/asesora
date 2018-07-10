require_relative '../services/subjects/service'

module Actions
  class UpdateSubject
    def self.do(id:, proposal:, proposals_description:, analysis:, topics:, solicitude_id:)
      ::Subjects::Service.update(id, proposal, proposals_description, analysis, topics, solicitude_id)
    end
  end
end
