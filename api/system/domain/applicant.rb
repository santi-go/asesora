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

      def initialize(id)
        @id = id
        @state={}
      end

      def memento
        memento= @state.clone
        memento[:signature]= @id
        memento[:timestamp]= Time.now.to_i
        memento
      end

      def remind memento
        return unless memento[:signature]==@id
        state_candidate = memento.clone
        state_candidate.delete :signature
        state_candidate.delete :timestamp
        @state = state_candidate
      end

      private_class_method :new

      def identify
        @id
      end

      def name= a_name
        @name=a_name
        @state[:name]=a_name
      end

      def surname= a_surname
        @surname = a_surname
      end

      def email= an_email
        @email= an_email
      end

      def phonenumber= a_phonenumber
        @phonenumber= a_phonenumber
      end

      def serialize
        {
          "name" => @state[:name],
          "surname" => @surname,
          "email" => @email,
          "phonenumber" => @phonenumber,
          "id" => @id
        }
      end
    end
  end
