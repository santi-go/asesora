
module Domain
  class Company

    def self.from_document(document)
      company = new(
        document['name'],
        document['cif'],
        document['employees'],
        document['cnae']
      )

      company
    end

    def self.with(name, cif, employees, cnae)
      company = new(
        name,
        cif,
        employees,
        cnae
      )

      company
    end

    def initialize(name, cif, employees, cnae)
      @name = name
      @cif = cif
      @employees = employees
      @cnae = cnae

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
