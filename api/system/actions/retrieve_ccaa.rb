require_relative '../services/ccaa/service'

module Actions
  class RetrieveCcaa
    def self.do(*_)
      ::Ccaa::Service.all
    end
  end
end
