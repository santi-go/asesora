require_relative '../services/navbar/service'

module Actions
  class RetrieveNavbar
    def self.do(*_)
      ::Navbar::Service.retrieve
    end
  end
end
