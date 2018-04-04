require_relative '../../domain/about'

module About
  class Collection
    @collection = [{
      "name" => 'Asesora',
      "description" => 'Registro de asesoramientos técnicos en salud laboral.',
      "version" => '0.0.1'
    }]

    class << self
      def retrieve
        document = find

        Domain::About.from_document(document)
      end

      private

      def find
        @collection.first
      end
    end
  end
end
