require_relative '../../domain/company'
require_relative 'collection'

module Companies
  class Service
    def self.create(name, cif, employees, cnae)
      return create_empty() if cif == ""

      company = Domain::Company.with(name, cif, employees, cnae)
      Collection.create(company).serialize
    end

    def self.retrieve(id, edition_moment = nil)
      retrieved = Collection.retrieve(id, edition_moment)
      return {} if (retrieved == false)
      retrieved.serialize
    end

    def self.delete(id)
      Collection.delete(id)
    end

    def self.all(criteria)
      Collection.all(criteria).serialize
    end

    def self.all_by(criteria)
      companies = Collection.all_by(criteria)
      companies.map do |company|
        company.serialize
      end
    end

    def self.update(name, cif, employees, cnae)
      cif = cif.upcase
      company = Domain::Company.with(name, cif, employees, cnae)
      if Collection.retrieve(cif) == false
        Collection.create(company).serialize
      else
        Collection.update(cif, company).serialize
      end
    end

    def self.create_empty()
      Domain::Company.with("", "", "", "").serialize
    end
  end
end
