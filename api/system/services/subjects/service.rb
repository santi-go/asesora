require_relative '../../domain/subject'
require_relative 'collection'

module Subjects
  class Service
    def self.create(solicitude_id, proposal, analysis, topics)
      subject = Domain::Subject.with(solicitude_id, proposal, analysis, topics)

      Collection.create(subject).serialize
    end
  end
end
