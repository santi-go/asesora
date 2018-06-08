require_relative './solicitude'
require_relative './company'

  module Domain
    class List
      def initialize(collection, type)
        @list = []
        collection.each do |element|
            @list << type.from_document(element)
        end
      end

      def self.from_document(collection, type)
          List.new(collection, type)
      end

      def serialize
        @list.map{|item| item.serialize()}
      end
    end
  end
