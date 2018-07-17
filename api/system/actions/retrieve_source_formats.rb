require_relative '../services/catalogs/service'

module Actions
  class RetrieveSourceFormats
    def self.do(*_)
      ::Catalogs::Service.source_formats
    end
  end
end
