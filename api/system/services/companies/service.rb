require_relative '../../domain/company'
require_relative 'collection'

module Companies
  class Service
    def self.create(name, cif, employees, cnae)
      return create_empty() if cif == ""
      cif.upcase!
      company = Domain::Company.with(name, cif, employees, cnae)
      Collection.create(company)
    end

    def self.retrieve(id)
      return self.create_empty().serialize  if id == ""
      id.upcase!
      result = Collection.retrieve(id)

      return result.serialize if(result != false)
      return {}
    end

    def self.all(criteria)
      companies = Collection.all(criteria)
      companies.map do |company|
        company.serialize
      end
    end

    def self.update(name, cif, employees, cnae)
      cif = cif.upcase
      company = Domain::Company.with(name, cif, employees, cnae)
      if Collection.retrieve(cif) == false
        Collection.create(company)
      else
        Collection.update(cif, company).serialize
      end
    end

    def self.create_empty()
      Domain::Company.with("", "", "", "")
    end
  end
end
