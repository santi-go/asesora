module Domain
  class Company
    def self.from_document(document)
      company = new(document['cif'])
      company.name = document['name']
      company.employees = document['employees']
      company.cnae = document['cnae']
      
      company
    end
    
    def self.with(name, cif, employees, cnae)
      company = new(cif)
      company.name = name
      company.employees = employees
      company.cnae = cnae
      
      company
    end

    
    def initialize(cif)
      @cif = cif
      @state = {}
    end

    def memento
      memento = @state.clone
      memento[:signature] = @cif
      memento[:timestamp] = Time.now.to_i
      memento
    end

    def remind(memento)
      return unless memento[:signature] == @cif
      state_candidate = memento.clone
      state_candidate.delete(:signature)
      state_candidate.delete(:timestamp)
      @state = state_candidate
    end

    private_class_method :new

    def identify
      @cif
    end

    def name=(a_name)
      @name = a_name
      @state[:name] = a_name
    end
    
    def employees=(a_employees)
      @employees = a_employees
      @state[:employees] = a_employees
    end

    def cnae=(a_cnae)
      @cnae = a_cnae
    end

    def serialize
      {
        "name" => @state[:name],
        "cif" => @cif,
        "employees" => @state[:employees],
        "cnae" => @cnae
      }
    end
  end
end
