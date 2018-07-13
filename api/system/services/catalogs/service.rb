module Catalogs
  class Service
    class << self
      def close_reasons
        read("close_reasons.json")
      end

      def cnae
        read("cnae.json")
      end

      def topics
        read("topics.json")
      end

      def ccaa
        read("ccaa.json")
      end

      def proposals
        read("proposals.json")
      end

      private
      
      def read(name)
        from_path = File.dirname(__FILE__)
        collection_file = File.join(from_path, "collections", name)
        catalog = File.read(collection_file, encoding: 'UTF-8')
        JSON.parse(catalog)
      end
    end
  end
end
