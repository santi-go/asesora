require_relative '../services/salutations/service'

module Actions
  class HelloWorld
    def self.do(name:)
      ::Salutations::Service.greet(name)
    end
  end
end
