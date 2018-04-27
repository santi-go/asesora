require_relative 'retrieve_about'
require_relative 'retrieve_dictionary'
require_relative 'create_solicitude'
require_relative 'update_solicitude'
require_relative 'retrieve_solicitudes'
require_relative 'retrieve_solicitude'


module Actions

  def self.retrieve_about
    ActionContext.new(Actions::RetrieveAbout)
  end

  def self.retrieve_dictionary_for(locale)
    context = ActionContext.new(Actions::RetrieveDictionary)
    context.add(:locale, locale)
    context
  end

  def self.create_solicitude(text, name, surname, email, phonenumber, date, company_name, company_cif, company_employees, company_cnae)
    context = ActionContext.new(Actions::CreateSolicitude)
    context.add(:text, text)
    context.add(:name, name)
    context.add(:surname, surname)
    context.add(:email, email)
    context.add(:phonenumber, phonenumber)
    context.add(:date, date)
    context.add(:company_name, company_name)
    context.add(:company_cif, company_cif)
    context.add(:company_employees, company_employees)
    context.add(:company_cnae, company_cnae)
    context
  end

  def self.update_solicitude(text, name, surname, email, phonenumber, date, company_name, company_cif, company_employees, company_cnae, creation_moment)
    context = ActionContext.new(Actions::UpdateSolicitude)
    context.add(:text, text)
    context.add(:name, name)
    context.add(:surname, surname)
    context.add(:email, email)
    context.add(:phonenumber, phonenumber)
    context.add(:date, date)
    context.add(:company_name, company_name)
    context.add(:company_cif, company_cif)
    context.add(:company_employees, company_employees)
    context.add(:company_cnae, company_cnae)
    context.add(:creation_moment, creation_moment)
    context
  end

  def self.retrieve_solicitudes
    ActionContext.new(Actions::RetrieveSolicitudes)
  end

  def self.retrieve_solicitude(id)
    context = ActionContext.new(Actions::RetrieveSolicitude)
    context.add(:id, id)
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
