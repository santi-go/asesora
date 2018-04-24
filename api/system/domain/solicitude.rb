require 'date'

module Domain
  class Solicitude
    attr_accessor :text

    def self.from_document(document)
      solicitude = new(
        document['name'],
        document['surname'],
        document['email'],
        document['phonenumber'],
        document['date'],
        document['creation_moment']
      )
      solicitude.text = document['text']

      solicitude
    end

    def self.with(name, surname, email, phonenumber, date, text, creation_moment = nil)
      solicitude = new(
        name,
        surname,
        email,
        phonenumber,
        date,
        creation_moment
      )
      solicitude.text = text

      solicitude
    end

    def initialize(name, surname, email, phonenumber, date, creation_moment = nil)
      @name = name
      @surname = surname
      @email = email
      @phonenumber = phonenumber
      @date = parse(date)
      @creation_moment = creation_moment || DateTime.now.strftime("%Q")
    end

    def serialize
      {
        "name" => @name,
        "surname" => @surname,
        "email" => @email,
        "phonenumber" => @phonenumber,
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
