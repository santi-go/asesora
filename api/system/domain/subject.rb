module Domain
    class Subject
      def self.from_document(document)
        subject = new(
          document['solicitude_id'],
          document['id'])

        subject.proposal = document['proposal']
        subject.analysis = document['analysis']
        subject.topics = document['topics']

        subject
      end

      def self.with(solicitude_id, proposal, analysis, topics, id = nil)
        subject = new(solicitude_id, id)
        subject.proposal = proposal
        subject.analysis = analysis
        subject.topics = topics

        subject
      end

      attr_writer :proposal, :analysis, :topics

      def initialize(solicitude_id, id = nil)
        @solicitude_id = solicitude_id
        @id = id || DateTime.now.strftime("%Q")
      end

      private_class_method :new


      def serialize
        {
          "proposal" => @proposal,
          "analysis" => @analysis,
          "topics" => @topics,
          "solicitude_id" => @solicitude_id,
          "id" => @id
        }
      end
    end
  end
