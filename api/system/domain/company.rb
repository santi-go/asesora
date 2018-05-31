
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
    
    attr_writer :name, :employees, :cnae
    
    def initialize(cif)
      @cif = cif
    end
    private_class_method :new

    def identify
      @cif
    end
    
    def serialize
      {
        "name" => @name,
        "cif" => @cif,
        "employees" => @employees,
        "cnae" => @cnae
      }
    end
  end
end
