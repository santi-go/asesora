require_relative '../../domain/subject'
require_relative 'collection'

module Subjects
  class Service
    def self.create(solicitude_id, proposal, proposals_description,analysis, topics)
      subject = Domain::Subject.with(solicitude_id, proposal, proposals_description, analysis, topics)

      Collection.create(subject).serialize
    end

    def self.update(id, proposal, proposals_description, analysis, topics, solicitude_id)
      subject = Domain::Subject.with(solicitude_id, proposal, proposals_description, analysis, topics, id)
      Collection.update(subject, id).serialize
    end

    def self.all_by(solicitude_id)
      Collection.all_by(solicitude_id).serialize
    end
  end
end
