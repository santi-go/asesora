require_relative 'retrieve_about'
require_relative 'retrieve_dictionary'
require_relative 'create_solicitude'

module Actions

  def self.retrieve_about
    ActionContext.new(Actions::RetrieveAbout)
  end

  def self.retrieve_dictionary_for(locale)
    context = ActionContext.new(Actions::RetrieveDictionary)
    context.add(:locale, locale)
    context
  end

  def self.create_solicitude(text, applicant, date)
    context = ActionContext.new(Actions::CreateSolicitude)
    context.add(:text, text)
    context.add(:applicant, applicant)
    context.add(:date, date)
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
