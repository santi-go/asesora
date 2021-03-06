require_relative '../../infrastructure/clients'
require_relative '../../domain/solicitude'
require_relative '../../domain/list'

module Solicitudes
  class Collection
    class << self
      def create(solicitude)
        serialized = solicitude.serialize()

        document = MongoClient.create(serialized)

        Domain::Solicitude.from_document(document)
      end

      def update(creation_moment, solicitude)
        serialized = solicitude.serialize()

        document = MongoClient.update(creation_moment, serialized)

        return if document.nil?

        Domain::Solicitude.from_document(document)
      end

      def delete(id)
        MongoClient.delete(id)
      end

      def retrieve(id)
        document = MongoClient.retrieve(id)
        return nil if document == nil
        solicitude = Domain::Solicitude.from_document(document)

        solicitude
      end

      def all
        solicitudes = MongoClient.all

        Domain::List.from_document(solicitudes, Domain::Solicitude)
      end

      def all_by(criteria)
        minimun_length = 3
        list = criteria.select{ |field, value| value.length >= minimun_length }

        result = MongoClient.all_by(list)

        solicitudes = result.map do |solicitude|
          Domain::Solicitude.from_document(solicitude)
        end
        solicitudes
      end

      def times_company(cif)
        MongoClient.times_company(cif)
      end

      private

      class MongoClient
        DESCENDENT = -1
        class << self

          def create(descriptor)
            client[:solicitudes].insert_one(descriptor)
            descriptor
          end

          def retrieve(id)
            documents = client[:solicitudes].find({"creation_moment": id})

            documents.first
          end

          def delete(id)
            client[:solicitudes].delete_one({"creation_moment": id})
          end

          def update(creation_moment, data)
            client[:solicitudes].find_one_and_replace({ creation_moment: creation_moment }, data, :return_document => :after)
          end

          def all
            client[:solicitudes].find().sort({"date": DESCENDENT, "creation_moment": DESCENDENT})
          end

          def all_by(criteria)
            list = {}
            criteria.each do |key, value|
              regex = /#{value}/i
              chain = { key => {"$regex": regex}}
              list.merge!(chain)
            end
            documents = client[:solicitudes].find(list)
          end

          def times_company(cif)
            companies = client[:solicitudes].find({"company": cif})
            return 0 if companies.nil?
            companies.count()
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
