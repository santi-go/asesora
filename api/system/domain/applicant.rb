module Domain
    class Applicant
      def self.from_document(document)
        applicant = new(document['id'])
        applicant.name = document['name']
        applicant.surname = document['surname']
        applicant.email = document['email']
        applicant.phonenumber = document['phonenumber']
  
        applicant
      end
  
      def self.with(name, surname, email, phonenumber, id)
        applicant = new(id)
        applicant.name = name
        applicant.surname = surname
        applicant.email = email
        applicant.phonenumber = phonenumber
  
        applicant
      end
      
      attr_writer :name, :surname, :email, :phonenumber

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
          "id" => @id
        }
      end
    end
  end
  