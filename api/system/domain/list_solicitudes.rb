require_relative './solicitude'

  module Domain
    class ListSolicitudes
      def initialize(solicitudes)
        @list_solicitude = []
        solicitudes.each do |element|
          @list_solicitude << Domain::Solicitude.from_document(element)
        end
      end

      def self.from_document(solicitudes)
          ListSolicitudes.new(solicitudes)
      end

      def serialize
        @list_solicitude.map{|i| i.serialize()}
      end
    end
  end
