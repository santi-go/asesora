require_relative 'retrieve_about'
require_relative 'retrieve_dictionary'

module Actions

  def self.retrieve_about
    ActionContext.new(Actions::RetrieveAbout)
  end

  def self.retrieve_dictionary_for(locale)
    context = ActionContext.new(Actions::RetrieveDictionary)
    context.add(:locale, locale)
    context
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
