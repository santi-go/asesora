require_relative '../services/subjects/service'

module Actions
  class CreateSubject
      def self.do(solicitude_id:, proposal:, analysis:, topics:)
        ::Subjects::Service.create(solicitude_id, proposal, analysis, topics)
      end
  end
end