require_relative '../../domain/company'
require_relative 'collection'

module Companies
  class Service
    def self.create(name, cif, employees, cnae)
      company = Domain::Company.with(name, cif, employees, cnae)
      Collection.create(company)
    end

    def self.retrieve(id)
      result = Collection.retrieve(id)
      return result.serialize if(result != false)
      return {}
    end
  end
end
