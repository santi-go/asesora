require_relative '../services/subjects/service'

module Actions
  class CreateSubject
      def self.do(solicitude_id:, proposal:, description:, analysis:, topics:)
        ::Subjects::Service.create(solicitude_id, proposal, description, analysis, topics)
      end
  end
end
