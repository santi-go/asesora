module Translation
  class Collection
    DEFAULT_LOCALE = 'es'
    @collection = {
        "es" => { 
            "description": "aplicacion asesora"
        },
        "en" => { 
            "description": "asesora application"
        }
    }

    class << self
      def retrieve(locale)
        locale = DEFAULT_LOCALE unless @collection.has_key?(locale)

        @collection[locale]
      end
    end
  end
end
