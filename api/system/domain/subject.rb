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
        subject.counseling_comment = document['counseling_comment']
        subject.closing_moment = document['closing_moment']

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

      attr_writer :proposal, :description, :analysis, :topics, :reason, :counseling_comment, :closing_moment

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
          "counseling_comment" => @counseling_comment,
          "closing_moment" => @closing_moment,
          "id" => @id
        }
      end
    end
  end
