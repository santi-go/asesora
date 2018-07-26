require_relative '../../infrastructure/clients'
require_relative '../../domain/subject'

module Subjects
  class Collection
    class << self
      def create(subject)
        serialized = subject.serialize()

        document = MongoClient.create(serialized)
        Domain::Subject.from_document(document)
      end

      def update(subject, id)
        serialized = subject.serialize()

        document = MongoClient.update(serialized, id)

        return if document.nil?

        Domain::Subject.from_document(document)
      end

      def retrieve(id)
        subject = MongoClient.find(id)
        return subject if subject == nil
        Domain::Subject.from_document(subject)
      end

      def delete(id)
        MongoClient.delete(id)
      end

      def all_by(solicitude_id)
        subjects = MongoClient.all_by(solicitude_id)

        Domain::List.from_document(subjects, Domain::Subject)
      end

      private

    class MongoClient
      class << self
        def create(descriptor)
          client[:subjects].insert_one(descriptor)
          descriptor
        end

        def all_by(solicitude_id)
          client[:subjects].find({"solicitude_id": solicitude_id})
        end

        def update(subject, id)
          client[:subjects].find_one_and_replace({ "id": id }, subject, :return_document => :after)
        end

        def find(id)
          client[:subjects].find({"id": id}).first
        end

        def delete(id)
          client[:subjects].delete_one({"id": id})
        end

        private

          def client
            @client ||= Infrastructure::Clients.mongo
          end
        end
      end
    end
  end
end
