require_relative 'retrieve_about'

module Actions
  class About
    def self.retrieve
      ActionContext.new(Actions::RetrieveAbout)
    end
  end

  class ActionContext
    def initialize(action)
      @action = action
      @context= {}
    end

    def add(key, value)
      @context[key]=value
    end

    def do
      @action.do(@context)
    end
  end
end
