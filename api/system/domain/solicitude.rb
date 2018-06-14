require 'date'

module Domain
  class Solicitude
    def self.from_document(document)
      solicitude = new(
        document['applicant'],
        document['company'],
        document['creation_moment'],
        document['edition_moment']
      )
      solicitude.solicited_at(document['date'])
      solicitude.text = document['text']
      
      solicitude
    end
    
    def self.with(date, text, applicant, company, creation_moment = nil)
      solicitude = new(
        applicant,
        company,
        creation_moment
      )
      solicitude.solicited_at(date)
      solicitude.text = text
      
      solicitude
    end
      
    attr_writer :text, :date

    def initialize(applicant, company, creation_moment = nil, edition_moment = nil)
      @applicant = applicant
      @company=company
      @creation_moment = creation_moment || DateTime.now.strftime("%Q")
      @edition_moment = edition_moment || Time.now.to_i
    end
    private_class_method :new

    def solicited_at(date)
      @date = parse(date)
    end

    def serialize
      {
        "date" => @date.to_s,
        "text" => @text,
        "applicant" => @applicant,
        "creation_moment" => @creation_moment,
        "edition_moment" => @edition_moment,
        "company" => @company
      }
    end

    private

    def parse(date)
      return default_date if date.empty?

      return Date.parse(date)
    end

    def default_date
      return Date.today
    end
  end
end
