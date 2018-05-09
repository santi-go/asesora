require_relative '../services/solicitudes/service'

module Actions
  class RetrieveSolicitudes
    def self.do(*_)
      solicitudes = ::Solicitudes::Service.all
      solicitudes.map do |solicitude|
        company = ::Companies::Service.retrieve(solicitude['company'])
        add_with_prefix(solicitude,company,'company')
      end
    end

    def self.add_with_prefix(base, added, prefix)
        prefixed = prefix(added,prefix)
        add(base,prefixed)
    end

    def self.prefix(base, prefix)
        prefixed = {}
        base.each {|key,value|
          prefixed[prefix+'_'+key] = value
        }
        prefixed
    end

    def self.add(base,added)
      base.merge(added)
    end

  end
end
