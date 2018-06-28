require_relative '../../domain/company'
require_relative 'collection'

module Companies
  class Service
    def self.create(name, cif, employees, cnae)
      return Domain::Company.nullified.serialize if cif == ""
      cif = cif.upcase
      company = Domain::Company.with(name, cif, employees, cnae)
      create_or_update(cif, company)
    end

    def self.retrieve(id, edition_moment = nil)
      retrieved = Collection.retrieve(id, edition_moment)
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
      create_or_update(cif, company)
    end

    def self.create_or_update(cif, company)
      if Collection.retrieve(cif).is_a?(Domain::Company)
        Collection.update(cif, company).serialize
      else Collection.retrieve(cif).is_a?(Domain::NullCompany)
        Collection.create(company).serialize
      end
    end
  end
end
