require_relative '../services/subjects/service'

module Actions
  class CloseSubject
    def self.do(id:, solicitude_id:, proposal:, description:, analysis:, topics:, reason:, comments:, closing_moment:)
      if id.nil?
        subject = create(solicitude_id, proposal, description, analysis, topics)
      else
        subject = update(solicitude_id, id, proposal, description, analysis, topics)
      end
      if closing_moment.nil?
        ::Subjects::Service.close(subject['id'], reason, comments)
      else
        subject
      end
    end

    private

    def self.create(solicitude_id, proposal, description, analysis, topics)
      ::Subjects::Service.create(
        solicitude_id,
        proposal,
        description,
        analysis,
        topics
      )
    end

    def self.update(solicitude_id, id, proposal, description, analysis, topics)
      ::Subjects::Service.update(
        solicitude_id,
        id,
        proposal,
        description,
        analysis,
        topics
      )
    end
  end
end
