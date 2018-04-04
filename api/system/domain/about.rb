
module Domain
  class About
    def self.from_document(document)
      new(
        document['name'],
        document['description'],
        document['version']
      )
    end

    def initialize(name, description, version)
      @name = name
      @description = description
      @version = version
    end

    def serialize
      {
        "name" => @name,
        "description" => @description,
        "version" => @version
      }
    end
  end
end
