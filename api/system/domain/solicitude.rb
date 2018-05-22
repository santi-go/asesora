require 'date'

module Domain
  class Solicitude
    attr_accessor :text

    def self.from_document(document)
      solicitude = new(
        document['date'],
        document['applicant'],
        document['company'],
        document['creation_moment']
      )
      solicitude.text = document['text']

      solicitude
    end

    def self.with(date, text, applicant, company, creation_moment = nil)
      solicitude = new(
        date,
        applicant,
        company,
        creation_moment
      )
      solicitude.text = text

      solicitude
    end

    def initialize(date, applicant, company, creation_moment = nil)
      @date = parse(date)
      @applicant = applicant
      @company=company
      @creation_moment = creation_moment || DateTime.now.strftime("%Q")
    end

    def serialize
      {
        "date" => @date.to_s,
        "text" => @text,
        "applicant" => @applicant,
        "creation_moment" => @creation_moment,
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
