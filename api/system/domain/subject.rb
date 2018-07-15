module Domain
    class Subject
      def self.from_document(document)
        subject = new(
          document['solicitude_id'],
          document['id'])

        subject.proposal = document['proposal']
        subject.description = document['description']
        subject.analysis = document['analysis']
        subject.topics = document['topics']
        subject.reason = document['reason']
        subject.comments = document['comments']
        subject.closed = document['closed']

        subject
      end

      def self.with(solicitude_id, proposal, description, analysis, topics, id = nil)
        subject = new(solicitude_id, id)
        subject.proposal = proposal
        subject.description = description
        subject.analysis = analysis
        subject.topics = topics

        subject
      end

      attr_writer :proposal, :description, :analysis, :topics, :reason, :comments, :closed

      def initialize(solicitude_id, id = nil)
        @solicitude_id = solicitude_id
        @id = id || DateTime.now.strftime("%Q")
      end

      private_class_method :new


      def serialize
        {
          "proposal" => @proposal,
          "description" => @description,
          "analysis" => @analysis,
          "topics" => @topics,
          "solicitude_id" => @solicitude_id,
          "reason" => @reason,
          "comments" => @comments,
          "closed" => @closed,
          "id" => @id
        }
      end
    end
  end
