require_relative '../../domain/subject'
require_relative 'collection'

module Subjects
  class Service
    def self.create(solicitude_id, proposal, description,analysis, topics)
      subject = Domain::Subject.with(solicitude_id, proposal, description, analysis, topics)

      Collection.create(subject).serialize
    end

    def self.update(solicitude_id, id, proposal, description, analysis, topics)
      subject = Collection.retrieve(id)
      subject.proposal = proposal
      subject.description = description
      subject.analysis = analysis
      subject.topics = topics

      collection = Collection.update(subject, id)

      return if collection.nil?

      collection.serialize
    end

    def self.close(subject, id, reason, comments, closed)
      return Collection.retrieve(id).serialize if !(closed.nil? || closed.empty?)

      subject = Collection.retrieve(id)
      subject.reason = reason
      subject.comments = comments
      subject.closed = DateTime.now

      updated_subject = Collection.update(subject, id)
      updated_subject.serialize
    end

    def self.all_by(solicitude_id)
      Collection.all_by(solicitude_id).serialize
    end
  end
end
