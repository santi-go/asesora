require 'date'

module Domain
  class Solicitude
    attr_accessor :text

    def self.from_document(document)
      solicitude = new(
        document['applicant']['name'],
        document['applicant']['secondname'],
        document['applicant']['email'],
        document['applicant']['phonenumber'],
        document['date'],
        document['creation_moment']
      )
      solicitude.text = document['text']

      solicitude
    end

    def self.with(applicant, date, text, creation_moment = nil)
      solicitude = new(
        applicant['name'],
        applicant['secondname'],
        applicant['email'],
        applicant['phonenumber'],
        date,
        creation_moment
      )
      solicitude.text = text

      solicitude
    end

    def initialize(applicant_name, applicant_secondname, applicant_email, applicant_phonenumber, date, creation_moment = nil)
      @applicant_name = applicant_name
      @applicant_secondname = applicant_secondname
      @applicant_email = applicant_email
      @applicant_phonenumber = applicant_phonenumber
      @date = parse(date)
      @creation_moment = creation_moment || DateTime.now.strftime("%Q")
    end

    def serialize
      {
        "applicant" => {
          "name" => @applicant_name,
          "secondname" => @applicant_secondname,
          "email" => @applicant_email,
          "phonenumber" => @applicant_phonenumber
        },
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
