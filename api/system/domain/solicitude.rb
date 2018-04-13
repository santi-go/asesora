require 'date'

module Domain
  class Solicitude
    attr_accessor :text

    def self.from_document(document)
      solicitude = new(
        document['applicant'],
        document['date'],
        document['creation_moment']
      )
      solicitude.text = document['text']

      solicitude
    end

    def initialize(applicant, date, creation_moment = nil)
      @applicant = applicant
      @date = parse(date)
      @creation_moment = creation_moment || DateTime.now.strftime("%Q")
    end

    def serialize
      {
        "applicant" => @applicant,
        "text" => @text,
        "date" => @date.to_s,
        "creation_moment" => @creation_moment
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
