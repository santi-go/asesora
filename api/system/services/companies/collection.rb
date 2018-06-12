require_relative '../../domain/company'
require_relative '../../domain/list'
require 'mongo'

module Companies
  class Collection
    class << self
      def create(company)
        memento = company.memento
        serialized = company.serialize()
        id = serialized["cif"]
        
        id.upcase!

        company = retrieve(id)

        return company if company

        document = MongoClient.create(serialized)
        MongoClient.store(memento)
        Domain::Company.from_document(document)
      end

      def retrieve(id, timestamp = Time.now.to_i)

        document = MongoClient.retrieve(id)
        return false if document.nil?
        company = Domain::Company.from_document(document)
        memento = MongoClient.retrieve_state_at(timestamp, company.identify)
        company.remind(memento) unless memento.nil?
        company
      end

      def delete(id)
        MongoClient.delete(id)
      end

      def all(criteria)
        return [] if criteria[:name].length < 3

        name = criteria[:name]
        cnae = criteria[:cnae]

        name_regex = /#{name}/i
        list = MongoClient.all(name_regex)

        if cnae != ""
          list = list.select{|company| company["cnae"].include?(cnae)}
        end

        Domain::List.from_document(list, Domain::Company)
      end

      def all_by(criteria)
        minimun_length = 3
        list = criteria.select{ |field, value| value.length >= minimun_length }

        result = MongoClient.all_by(list)

        companies = result.map do |company|
          Domain::Company.from_document(company)
        end
        companies
      end

      def update(cif, company)
        serialized = company.serialize()
        memento = company.memento

        document = MongoClient.update(cif, serialized)

        return if document.nil?
        MongoClient.store(memento)
        Domain::Company.from_document(document)
      end

      private

      class MongoClient
        class << self

          def create(descriptor)
            client[:companies].insert_one(descriptor)
            descriptor
          end

          def store(memento)
            client[:company_memento].insert_one(memento)
          end

          def retrieve(id)
            documents = client[:companies].find({"cif": id})
            documents.first
          end

          def retrieve_state_at(timestamp, id)
            memento = client[:company_memento]
                            .find({"timestamp":{"$lte": timestamp}, "signature": id})
                            .sort({"timestamp": -1})
                            .first
            memento
          end

          def delete(id)
            client[:companies].find_one_and_delete({"cif": id})
          end

          def all(regex)
            documents = client[:companies].find({"name":{ "$regex": regex}})
            documents
          end

          def all_by(criteria)
            list = {}
            criteria.each do |key, value|
              regex = /#{value}/i
              chain = { key => {"$regex": regex}}
              list.merge!(chain)
            end
            documents = client[:companies].find(list)
          end

          def update(cif, company)
            client[:companies].find_one_and_replace({ "cif": cif }, company, :return_document => :after)
          end

          private

          def client
            mongo_uri = ENV['MONGODB_URI']
            Mongo::Logger.logger.level = Logger::INFO

            @client ||= Mongo::Client.new(mongo_uri, { max_pool_size: 5 })
          end
        end
      end
    end
  end
end
