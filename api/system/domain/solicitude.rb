require 'date'

module Domain
  class Solicitude
    def self.from_document(document)
      solicitude = new(
        document['applicant'],
        document['company'],
        document['creation_moment']
      )
      solicitude.edition_moment = document['edition_moment']
      solicitude.solicited_at(document['date'])
      solicitude.text = document['text']
      solicitude.source = document['source']

      solicitude
    end

    def self.with(date, text, source, applicant, company, creation_moment = nil, edition_moment = nil)
      solicitude = new(
        applicant,
        company,
        creation_moment
      )
      solicitude.edition_moment = Time.now.to_i
      solicitude.solicited_at(date)
      solicitude.text = text
      solicitude.source = source

      solicitude
    end

    attr_writer :text, :date, :source

    def initialize(applicant, company, creation_moment = nil)
      @applicant = applicant
      @company=company
      @creation_moment = creation_moment || DateTime.now.strftime("%Q")
    end
    private_class_method :new

    def solicited_at(date)
      @date = parse(date)
    end

    def edition_moment=(value)
      @edition_moment = value
    end

    def serialize
      {
        "date" => @date.to_s,
        "text" => @text,
        "source" => @source,
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
