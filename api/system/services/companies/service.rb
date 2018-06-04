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
      if not id
        return create_empty().serialize
      end

      if company_exists?(id)
        return Collection.retrieve(id).serialize
      end

      return {}
    end

    def self.all(criteria)
      companies = Collection.all(criteria)
      companies.map do |company|
        company.serialize
      end
    end

    def self.update(name, cif, employees, cnae)
      company = Domain::Company.with(name, cif, employees, cnae)
      if !company_exists?(cif)
        Collection.create(company)
      else
        Collection.update(cif, company).serialize
      end
    end

    def self.create_empty()
      Domain::Company.with("", "", "", "")
    end

    def self.company_exists?(id)
      id = id.upcase
      Collection.retrieve(id)
    end
  end
end
