require_relative '../../domain/subject'
require_relative 'collection'

module Subjects
  class Service
    def self.create(solicitude_id, proposal, description,analysis, topics)
      subject = Domain::Subject.with(solicitude_id, proposal, description, analysis, topics)

      Collection.create(subject).serialize
    end

    def self.update(solicitude_id, id, proposal, description, analysis, topics)
      subject = Domain::Subject.with(solicitude_id, proposal, description, analysis, topics, id)

      collection = Collection.update(subject, id)

      return if collection.nil?

      collection.serialize
    end

    def self.all_by(solicitude_id)
      Collection.all_by(solicitude_id).serialize
    end
  end
end
