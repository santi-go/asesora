module Domain
    class Applicant
  
      def self.from_document(document)
        applicant = new(
          document['name'],
          document['surname'],
          document['email'],
          document['phonenumber'],
          document['id']
        )
  
        applicant
      end
  
      def self.with(name, surname, email, phonenumber, id)
        applicant = new(
          name,
          surname,
          email,
          phonenumber,
          id
        )
  
        applicant
      end
  
      def initialize(name, surname, email, phonenumber, id)
        @name = name
        @surname = surname
        @email = email
        @phonenumber = phonenumber
        @id = id
      end

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
  