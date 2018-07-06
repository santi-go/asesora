module Domain
    class Applicant
      def self.from_document(document)
        applicant = new(document['id'])
        applicant.name = document['name']
        applicant.surname = document['surname']
        applicant.email = document['email']
        applicant.phonenumber = document['phonenumber']
        applicant.ccaa = document['ccaa']

        applicant
      end

      def self.with(name, surname, email, phonenumber, ccaa, id)
        applicant = new(id)
        applicant.name = name
        applicant.surname = surname
        applicant.email = email
        applicant.phonenumber = phonenumber
        applicant.ccaa = ccaa

        applicant
      end

      attr_writer :name, :surname, :email, :phonenumber, :ccaa

      def initialize(id)
        @id = id
      end
      private_class_method :new

      def identify
        @id
      end

      def serialize
        {
          "name" => @name,
          "surname" => @surname,
          "email" => @email,
          "phonenumber" => @phonenumber,
          "ccaa" => @ccaa,
          "id" => @id
        }
      end
    end
  end
