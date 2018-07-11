require_relative '../services/subjects/service'

module Actions
  class CloseSubject
    def self.do(id:, reason:, counseling_comment:)

    ::Subjects::Service.close(id, reason, counseling_comment)
    end
  end
end
