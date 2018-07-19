require_relative '../services/subjects/service'

module Actions
  class CloseSubject
    def self.do(id:, solicitude_id:, proposal:, description:, analysis:, topics:, reason:, comments:, closed:)
      if id.empty?
        subject = create(solicitude_id, proposal, description, analysis, topics)
      else
        subject = update(solicitude_id, id, proposal, description, analysis, topics)
      end

      subject = ::Subjects::Service.close(subject, subject['id'], reason, comments, closed)
      subject
    end

    private

    def self.is_not?(closed)
      closed.nil? || closed.empty?
    end

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
