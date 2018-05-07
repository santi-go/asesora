require_relative '../../domain/company'
require_relative 'collection'

module Companies
  class Service
    def self.create(name, cif, employees, cnae)
      company = Domain::Company.with(name, cif, employees, cnae)
      Collection.create(company).serialize
    end
  end
end
