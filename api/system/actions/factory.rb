require_relative 'retrieve_about'
require_relative 'retrieve_translations'

module Actions
  class About
    def self.retrieve
      ActionContext.new(Actions::RetrieveAbout)
    end
  end

  class Translation
    def self.retrieve(locale)
      context = ActionContext.new(Actions::RetrieveTranslations)
      context.add(:locale, locale)
      context
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
